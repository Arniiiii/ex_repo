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
