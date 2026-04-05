# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A library for generating C++ code from C++ "
HOMEPAGE="https://github.com/rm5248/libcppgenerate"
SRC_URI="https://github.com/rm5248/libcppgenerate/archive/refs/tags/${P}.tar.gz"

S="${WORKDIR}/libcppgenerate-${P}"

LICENSE="Apache-2.0"
SLOT="0"

KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/multiarch.patch"
)
