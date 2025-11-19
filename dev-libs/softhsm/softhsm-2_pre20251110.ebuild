# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/softhsm/SoftHSMv2.git"
	inherit git-r3
else
	COMMIT="70c7d0f03db04a44ab3057350509fd4f31ffbd5b"
	SRC_URI="https://github.com/softhsm/SoftHSMv2/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/SoftHSMv2-${COMMIT}"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~riscv ~sparc"
fi

DESCRIPTION="Software implementation of an HSM that supports PKCS 11 interface."
HOMEPAGE="https://www.softhsm.org/"

LICENSE="BSD-2"
SLOT="0"


IUSE="p11-kit migration-tool test static doc"

RESTRICT="!test? ( test )"

RDEPEND="
	migration-tool? ( dev-db/sqlite:3= )
	dev-libs/openssl:=
	!~dev-libs/softhsm-2.0.0:0
	p11-kit? ( app-crypt/p11-kit )
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gcc:=[cxx]
	virtual/pkgconfig
	test? ( dev-util/cppunit )
"

PATCHES=(
	"${FILESDIR}/0000_fix_sandbox_violation.patch"
)

src_configure() {
	# Test failures with LTO (bug #867637)
	append-flags -fno-strict-aliasing
	filter-lto

	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
		-DENABLE_P11_KIT=$(usex p11-kit)
		-DWITH_OBJECTSTORE_BACKEND_DB=$(usex migration-tool)
		-DWITH_MIGRATE=$(usex migration-tool)
		-DENABLE_STATIC=$(usex static)
		-DWITH_CRYPTO_BACKEND='openssl'

		# my default
		--log-level=DEBUG
		-DFETCHCONTENT_QUIET=OFF
	)

	cmake-multilib_src_configure
}

src_install() {
	if use doc; then
		einstalldocs
	fi

	cmake-multilib_src_install

	keepdir /var/lib/softhsm/tokens
}

pkg_postinst() {
	ewarn "I've got it, maybe you have got it during configuring of the project."
	ewarn "Since IDK how to forward CMake's warning here, so here's just copy-paste"
	ewarn ""
	ewarn "======================================================================"
	ewarn "SoftHSM has been configured to store sensitive data in non-page RAM"
	ewarn "(i.e. memory that is not swapped out to disk). This is the default and"
	ewarn "most secure configuration. Your system, however, is not configured to"
	ewarn "support this model in non-privileged accounts (i.e. user accounts)."
	ewarn ""
	ewarn ""
	ewarn ""
	ewarn "You can check the setting on your system by running the following"
	ewarn "command in a shell:"
	ewarn ""
	ewarn ""
	ewarn ""
	ewarn "        ulimit -l"
	ewarn ""
	ewarn ""
	ewarn ""
	ewarn "If this does not return \"unlimited\" and you plan to run SoftHSM from"
	ewarn "non-privileged accounts then you should edit the configuration file"
	ewarn "/etc/security/limits.conf (on most systems)."
	ewarn ""
	ewarn ""
	ewarn ""
	ewarn "You will need to add the following lines to this file:"
	ewarn ""
	ewarn ""
	ewarn ""
	ewarn "#<domain>       <type>          <item>          <value>"
	ewarn "*               -               memlock         unlimited"
	ewarn ""
	ewarn ""
	ewarn ""
	ewarn "Alternatively, you can elect to disable this feature of SoftHSM by"
	ewarn "re-running cmake with the option \"-DDISABLE_NON_PAGED_MEMORY=ON\"."
	ewarn "Please be advised that this may seriously degrade the security of"
	ewarn "SoftHSM."
	ewarn "======================================================================"
}
