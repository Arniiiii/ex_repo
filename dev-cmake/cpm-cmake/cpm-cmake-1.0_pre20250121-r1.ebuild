# Copyright 2026 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A CMake's NOT package manager. A tool for bundling dependencies in CMake"
HOMEPAGE="https://github.com/Arniiiii/CPM.cmake"

CPM_CMAKE_COMMIT="4d245d2e584298071e5f7723fc8fc6f02f79f9b5"

SRC_URI="https://github.com/Arniiiii/CPM.cmake/archive/${CPM_CMAKE_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/CPM.cmake-${CPM_CMAKE_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="${DEPEND}"

BDEPEND="
dev-build/cmake
"

PATCHES=(
	"${FILESDIR}/0001_status_included.patch"
)

src_prepare() {
	default
	sed -i "${S}/cmake/CPM.cmake" -e "s/1.0.0-development-version/${PV}/g" || die
}

src_install() {
	insinto /usr/share/cmake
	doins "${S}/cmake/CPM.cmake"

	if use doc; then
		einstalldocs
	fi
}

pkg_postinst() {
	einfo "If you want to use it, patch a project's \`getCPM.cmake\` so that you can "
	einfo "override its CPM_DOWNLOAD_LOCATION. Then, at configuring add next argument:"
	einfo "-DCPM_DOWNLOAD_LOCATION=/usr/share/cmake/CPM.cmake . If you write an"
	einfo "ebuild, then "
	einfo "-DCPM_DOWNLOAD_LOCATION=\$\{BROOT\}/usr/share/cmake/CPM.cmake is prefered"
	einfo "                                                                           "
	einfo "Also, don't use CPM if you can. Essentially, it's about 'how to do bundled "
	einfo "dependencies better', though it sucks when you have anything remotely      "
	einfo "complex. I've used it and now regret about it. Check an article at"
	einfo "https://michael.orlitzky.com/articles/motherfuckers_need_package_management"
	einfo ".xhtml"
}
