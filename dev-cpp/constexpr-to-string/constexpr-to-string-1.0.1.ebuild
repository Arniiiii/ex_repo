# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# it's a header-only lib, thus not cmake-multilib. However, examples and tests...
inherit cmake

DESCRIPTION="C++14 code to convert integers to strings at compile-time "
HOMEPAGE="https://github.com/Arniiiii/constexpr-to-string-cmake"

SRC_URI="
	https://github.com/Arniiiii/constexpr-to-string-cmake/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
"

S="${WORKDIR}/constexpr-to-string-cmake-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~arm64-macos ~ppc-macos ~x64-macos ~x64-solaris"
# IUSE=""

# REQUIRED_USE=""

# RESTRICT=""

# PROPERTIES=""

DEPEND=""

RDEPEND="${DEPEND}"

BDEPEND="
dev-build/cmake
"
