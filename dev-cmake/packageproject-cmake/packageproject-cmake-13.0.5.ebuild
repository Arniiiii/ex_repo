# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Amazing script for installing your projects in CMake!"
HOMEPAGE="https://github.com/Arniiiii/PackageProject.cmake"
SRC_URI="https://github.com/Arniiiii/PackageProject.cmake/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/PackageProject.cmake-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="!test? ( test )"

BDEPEND="
	test? ( dev-cmake/cpm-cmake dev-libs/libfmt )
"

src_configure() {
	# Gentoo users enable ccache via e.g. FEATURES=ccache or
	# other means. We don't want the build system to enable it for us.
	sed -i -e '/find_program(CCACHE_FOUND ccache)/d' CMakeLists.txt || die

	local mycmakeargs=(
		-DPackageProject.cmake_INSTALL=YES
		-DPACKAGE_PROJECT_ROOT_PATH="${EPREFIX}/usr/share/cmake/PackageProjectFiles"
	)

	cmake_src_configure

	if use test; then
		CMAKE_USE_DIR=${S}/test BUILD_DIR=${S}_build_test
		local mycmakeargs=(
			-DTEST_INSTALLED_VERSION=OFF
			-DTEST_INSTALLED_VERSION_PACKAGEPROJECT=OFF
			-DCPM_DOWNLOAD_LOCATION="${BROOT}/usr/share/cmake/CPM.cmake"
			-DCPM_LOCAL_PACKAGES_ONLY=1
		)
		einfo "CMake configure args for testing are: ${mycmakeargs}"
		cmake_src_configure
	fi
}

src_compile() {
	if use test; then
		CMAKE_USE_DIR=${S}/test BUILD_DIR=${S}_build_test
		cmake_src_compile
	fi
}

src_test() {
	CMAKE_USE_DIR=${S}/test BUILD_DIR=${S}_build_test
	cmake_src_test
}

src_install() {
	CMAKE_USE_DIR=${S} BUILD_DIR=${S}_build
	cmake_src_install
}

pkg_postinst() {
	einfo "You can use the package in CMake via"
	einfo "\`find_package(PackageProject.cmake VERSION xy.z.w)\`."
	einfo "Remember, if you use CPM, just add to configuration flags "
	einfo "\`-DCPM_LOCAL_PACKAGES_ONLY=1\` and everything is going to be ok."
}
