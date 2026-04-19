# Copyright 2026 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Lightweight structured concurrency for C++20"
HOMEPAGE="https://github.com/hudson-trading/corral"

EGIT_REPO_URI="https://github.com/hudson-trading/corral"
EGIT_BRANCH="master"
inherit cmake git-r3

LICENSE="MIT"
SLOT="0"

IUSE="test examples	doc"

RESTRICT="!test? ( test )"

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

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_INSTALL_RULES=OFF
		-DBUILD_TESTING=$(usex test ON OFF)
		-DSKIP_TESTS=$(usex test OFF ON)
		-DCORRAL_CATCH2=""
		-DCORRAL_BOOST="a" # here can be anything not same as ".*://.*"
		-DCORRAL_EXAMPLES=$(usex examples ON OFF)
		-DSKIP_EXAMPLES=$(usex examples OFF ON)

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
