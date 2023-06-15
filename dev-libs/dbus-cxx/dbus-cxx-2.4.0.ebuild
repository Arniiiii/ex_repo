# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="dbus c++ API library. Developer said it's threadsafe. c++17 required."
HOMEPAGE="https://dbus-cxx.github.io/index.html"
SRC_URI="https://github.com/dbus-cxx/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( BSD LGPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~arm ~ppc64 ~ppc ~riscv ~alpha ~hppa ~ia64 ~sparc"
IUSE="qt glib tools tests doc examples site"

DEPEND="
	dev-libs/cppgenerate
	sys-apps/dbus
	dev-libs/expat
	dev-libs/libsigc++

	tools? (
		dev-libs/popt
	)
	tests? (
		dev-libs/popt
	)
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
		dev-libs/libxslt
	)
	glib? (
		dev-libs/glib
	)
	qt? (
		dev-qt/qtdbus
	)
"

RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cmake
"


src_configure() {
	local mycmakeargs=(
		-DTOOLS_BUNDLED_CPPGENERATE=OFF
		-DENABLE_TOOLS=$(usex tools ON OFF)
		-DENABLE_EXAMPLES=$(usex examples ON OFF)
		-DENABLE_GLIB_SUPPORT=$(usex glib ON OFF)
		-DENABLE_QT_SUPPORT=$(usex qt ON OFF)

		-DBUILD_TESTING=$(usex tests ON OFF)
		-DENABLE_ROBUSTNESS_TESTS=$(usex tests ON OFF)

		-DBUILD_SITE=$(usex site ON OFF)

	)

	cmake_src_configure
}

