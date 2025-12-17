# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# header-only
inherit cmake

DESCRIPTION="Extremely fast, in memory, JSON and interface library for modern C++ "
HOMEPAGE="https://github.com/stephenberry/glaze"

SRC_URI="https://github.com/stephenberry/glaze/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/glaze-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~ppc ~ppc64 ~riscv ~sparc ~x86 ~amd64-linux ~x86-linux ~arm64-macos ~ppc-macos ~x64-macos ~x64-solaris" # no mips s390 because of dev-cpp/asio::gentoo .

IUSE="
	eetf-format
	test
	fuzzing
	examples
	doc
"

RESTRICT="!test? ( test )"

# REQUIRED_USE=""

DEPEND="
	eetf-format? (
		dev-lang/erlang
	)
	test? (
		dev-cpp/ut2-glaze
		dev-cpp/asio
		>=dev-cpp/eigen-3.4
	)
"

# RDEPEND="${DEPEND}"

BDEPEND="
	dev-build/cmake
"

# RESTRICT=""

PATCHES=(
	"${FILESDIR}/0010_gentoo_specific_fix.patch"
	# "${FILESDIR}/0011_fix_erlang.patch"
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_INSTALL_RULES=OFF
		-Dglaze_DEVELOPER_MODE=ON
		-Dglaze_ENABLE_FUZZING=$(usex fuzzing ON OFF)
		-Dglaze_BUILD_EXAMPLES=$(usex examples ON OFF)
		-DBUILD_TESTING=$(usex test ON OFF)
		-Dglaze_EETF_FORMAT=$(usex eetf-format ON OFF)

		# my default:
		-DFETCHCONTENT_QUIET=OFF
		--log-level=DEBUG
	)

	cmake_src_configure

}


src_test() {
	local CMAKE_SKIP_TESTS=(
		cli_menu_test # it is not a test: it is an interactive CLI program.
		asio_repe # often in timeout or not passes.
	)

	cmake_src_test
}

src_install() {
	if use doc; then
		einstalldocs
	fi

	cmake_src_install
}
