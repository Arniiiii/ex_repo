# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A library for generating C++ code from C++ "
HOMEPAGE="https://github.com/rm5248/libcppgenerate"
SRC_URI="https://github.com/rm5248/libcppgenerate/archive/refs/tags/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~arm ~ppc64 ~ppc ~riscv ~alpha ~hppa ~ia64 ~sparc"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/libcppgenerate-${P}"

PATCHES=(
	"${FILESDIR}/multiarch.patch"
)
