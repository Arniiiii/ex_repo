# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Professionally written C++ function traits library (single header-only) for retrieving info about any function (arg types, arg count, return type, etc.)"
HOMEPAGE="https://github.com/HexadigmSystems/FunctionTraits"

COMMIT="d4a6f8a96df2d8174219dc0a73f0201193b3c538"

SRC_URI="
https://github.com/HexadigmSystems/FunctionTraits/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
"

S="${WORKDIR}/FunctionTraits-${COMMIT}"

LICENSE="Hexadigm_Generic_C++_library"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/0000_basic_CMakeLists.txt_.patch"
)
