# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# it's a header-only lib, thus not cmake-multilib. However, examples, tests and benchmarks...
inherit cmake

DESCRIPTION="Asynchronous Low Latency C++ Logging Library"
HOMEPAGE="https://github.com/odygrd/quill"
SRC_URI="https://github.com/odygrd/quill/archive/a29940ebe1122556fa6d99be1929264469d6ec99.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/quill-a29940ebe1122556fa6d99be1929264469d6ec99"
# SRC_URI="https://github.com/odygrd/quill/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples test	extensive-test benchmarks valgrind doc"

REQUIRED_USE="extensive-test? ( test ) doc? ( examples ) "

RESTRICT="!test? ( test )"

RDEPEND="
valgrind? ( dev-debug/valgrind )
"

BDEPEND="
dev-build/cmake
doc? (
	app-text/doxygen
	dev-python/sphinx
	dev-python/breathe
	dev-python/furo
)
"

PATCHES=(
	"${FILESDIR}/0001_quill_10.0.0_cmake_and_pkgconfig.patch"
)

src_configure() {
	# Gentoo users enable ccache via e.g. FEATURES=ccache or
	# other means. We don't want the build system to enable it for us.
	sed -i -e '/find_program(CCACHE_FOUND ccache)/d' CMakeLists.txt || die

	local mycmakeargs=(
		-DQUILL_BUILD_EXAMPLES=$(usex examples ON OFF)
		-DQUILL_BUILD_TESTS=$(usex test ON OFF)
		-DQUILL_BUILD_BENCHMARKS=$(usex benchmarks true false)
		-DQUILL_DOCS_GEN=$(usex doc ON OFF)
		-DQUILL_USE_VALGRIND=$(usex valgrind ON OFF)
		-DQUILL_ENABLE_EXTENSIVE_TESTS=$(usex extensive-test ON OFF)
		-DQUILL_ENABLE_INSTALL=ON
	)

	if use x86 || use amd64; then
		mycmakeargs+=( -DQUILL_X86ARCH=ON )
	fi

	cmake_src_configure
}
