# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

# it's just a CMake script that installs another CMake script to
# folder with CMake utility modules (usually /usr/share/cmake/m.css/ ), thus not cmake-multilib.
inherit cmake python-single-r1

DESCRIPTION="m.css with patch to allow \`find_package\` from CMake via '\${m.css_SOURCE_DIR}'"
HOMEPAGE="https://github.com/mosra/m.css"

M_CSS_COMMIT="0a460a7a9973a41db48f735e7b49e4da9a876325"

SRC_URI="https://github.com/mosra/m.css/archive/${M_CSS_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/m.css-${M_CSS_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="dev-lang/python"

BDEPEND="
	dev-build/cmake
"

PATCHES=(
	"${FILESDIR}/0000_cmake.patch"
)

src_configure() {
	local mycmakeargs=(
	)

	cmake_src_configure
}

pkg_postinst() {
	einfo "You can use the package in CMake via"
	einfo "\`find_package(m.css VERSION 1.0)\`."
	einfo "Remember, if you use CPM, just add to configuration flags "
	einfo "\`-DCPM_LOCAL_PACKAGES_ONLY=1\` and everything is going to be ok."
}
