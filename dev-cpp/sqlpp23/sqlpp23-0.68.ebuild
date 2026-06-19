# Copyright 2026 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# it's a header-only lib, thus not cmake-multilib. However, examples, tests and benchmarks...
inherit cmake

DESCRIPTION="A type safe SQL library for C++ "
HOMEPAGE="https://github.com/rbock/sqlpp23"
SRC_URI="https://github.com/rbock/sqlpp23/archive/refs/tags/${PV}.tar.xz -> ${P}.tar.gz"
S="${WORKDIR}/sqlpp23-${PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sqlite3 mariadb mysql postgres test doc"

REQUIRED_USE=""

RESTRICT="!test? ( test )"

RDEPEND="
valgrind? ( dev-debug/valgrind )
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
		mycmakeargs+=(-DQUILL_X86ARCH=ON)
	fi

	cmake_src_configure
}
