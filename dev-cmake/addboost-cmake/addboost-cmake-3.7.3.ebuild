# Copyright 2026 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# it's just a CMake script that installs another CMake script to
# folder with CMake utility modules (usually /usr/share/cmake/AddBoost.cmake ), thus not cmake-multilib.
inherit cmake

DESCRIPTION="Yet another CMake script for finding or bundling Boost."
HOMEPAGE="https://github.com/Arniiiii/AddBoost.cmake"
SRC_URI="https://github.com/Arniiiii/AddBoost.cmake/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/AddBoost.cmake-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

BDEPEND="
	dev-cmake/cpm-cmake
"

src_configure() {
	local mycmakeargs=(
		-DAddBoost.cmake_INSTALL=YES
	)

	cmake_src_configure
}

src_install() {
	if use doc; then
		einstalldocs
	fi

	cmake_src_install
}

pkg_postinst() {
	einfo "You can use the package in CMake via"
	einfo "\`find_package(AddBoost.cmake VERSION xy.z.w)\`."
	einfo "Remember, if you use CPM, just add to configuration flags "
	einfo "\`-DCPM_LOCAL_PACKAGES_ONLY=1\` and everything is going to be ok."
}
