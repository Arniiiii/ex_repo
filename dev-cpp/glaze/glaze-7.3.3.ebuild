# Copyright 2026 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# it's a header-only lib, thus not cmake-multilib. However, examples, tests and benchmarks...
inherit cmake

DESCRIPTION="Extremely fast, in memory, JSON and interface library for modern C++ "
HOMEPAGE="https://github.com/stephenberry/glaze"
SRC_URI="https://github.com/stephenberry/glaze/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/glaze-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="eetf-format test fuzzing examples"
RESTRICT="!test? ( test )"

DEPEND="
	eetf-format? (
		dev-lang/erlang
	)
	test? (
		dev-cpp/ut2-glaze
		dev-libs/boost
		>=dev-cpp/eigen-3.4
	)
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/glaze-7.2.3-unbundle-test-deps.patch"
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_INSTALL_RULES=OFF
		-Dglaze_DEVELOPER_MODE=ON
		-Dglaze_ENABLE_FUZZING=$(usex fuzzing)
		-Dglaze_BUILD_EXAMPLES=$(usex examples)
		-DBUILD_TESTING=$(usex test)
		-Dglaze_EETF_FORMAT=$(usex eetf-format)
	)

	cmake_src_configure
}

src_test() {
	local CMAKE_SKIP_TESTS=(
		cli_menu_test        # it is not a test: it is an interactive CLI program.
	)

	cmake_src_test
}
