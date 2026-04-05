# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++20 μ(micro)/Unit Testing framework "
HOMEPAGE="https://github.com/boost-ext/ut"

SRC_URI="
	https://github.com/boost-ext/ut/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

S="${WORKDIR}/ut-${PV}"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-test-valgrind -benchmarks -examples -doc -experimental-c++-modules test "

REQUIRED_USE="!test? ( !test-valgrind )"

RESTRICT="!test? ( test )"

RDEPEND="${DEPEND}"

BDEPEND="
>=dev-build/cmake-4.0.0
"

PATCHES=(
	"${FILESDIR}/0000_make_cmake_produce_pkgconfig_for_headers.patch"
)

src_configure() {
	local mycmakeargs=(
		-DBOOST_UT_ENABLE_MEMCHECK=$(usex test-valgrind ON OFF)
		-DBOOST_UT_ENABLE_COVERAGE=OFF
		-DBOOST_UT_ENABLE_SANITIZERS=OFF
		-DBOOST_UT_BUILD_BENCHMARKS=$(usex benchmarks ON OFF)
		-DBOOST_UT_BUILD_EXAMPLES=$(usex examples ON OFF)
		-DBOOST_UT_BUILD_TESTS=$(usex test ON OFF)
		-DBOOST_UT_ENABLE_INSTALL=ON
		-DBOOST_UT_USE_WARNINGS_AS_ERORS=OFF
		-DBOOST_UT_DISABLE_MODULE=$(usex experimental-c++-modules OFF ON)

	)
	cmake_src_configure
}

src_install() {
	if use doc; then
		einstalldocs
	fi

	cmake_src_install
}
