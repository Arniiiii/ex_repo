# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Lightweight structured concurrency for C++20"
HOMEPAGE="https://github.com/hudson-trading/corral"

CORRAL_COMMIT="8d1a087f5e560633bcbce93cdae7bff06bf85ca4"

SRC_URI="https://github.com/hudson-trading/corral/archive/${CORRAL_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/corral-${CORRAL_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~ppc ~ppc64 ~riscv ~sparc ~x86 ~amd64-linux ~x86-linux ~arm64-macos ~ppc-macos ~x64-macos ~x64-solaris" # no mips s390 because of dev-cpp/asio::gentoo .

IUSE="
	test
	examples
	doc
"

RESTRICT="!test? ( test )"

# REQUIRED_USE=""

DEPEND="
	test? (
		dev-libs/boost
		<dev-cpp/catch-3.0.0:0
		dev-libs/openssl
	)
	examples? (
		dev-libs/boost
		dev-qt/qtbase
)
"

# RDEPEND="${DEPEND}"

BDEPEND="
	dev-cmake/cpm-cmake
	dev-cmake/packageproject-cmake
"

# RESTRICT=""

PATCHES=(
 "${FILESDIR}/0004_fix_install.patch"
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_INSTALL_RULES=OFF
		-DBUILD_TESTING=$(usex test ON OFF)
		-DCORRAL_CATCH2=""
		-DCORRAL_BOOST="a" # here can be anything not same as ".*://.*"
		-DCORRAL_EXAMPLES=$(usex examples ON OFF)

		-DCPM_DOWNLOAD_LOCATION=${BROOT}/usr/share/cmake/CPM.cmake
		-DCPM_LOCAL_PACKAGES_ONLY=1

		# my default:
		-DFETCHCONTENT_QUIET=OFF
		--log-level=DEBUG
	)

	cmake_src_configure

}

src_install() {
	if use doc; then
		einstalldocs
	fi

	cmake_src_install
}
