# Copyright 2026 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++14 code to convert integers to strings at compile-time "
HOMEPAGE="https://github.com/Arniiiii/constexpr-to-string-cmake"

SRC_URI="
	https://github.com/Arniiiii/constexpr-to-string-cmake/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
"

S="${WORKDIR}/constexpr-to-string-cmake-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
