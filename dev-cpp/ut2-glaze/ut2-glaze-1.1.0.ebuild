# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# it's a header-only lib, thus not cmake-multilib. However, examples and tests...
inherit cmake

DESCRIPTION="A stripped down fork of boost-ext ut2 "
HOMEPAGE="https://github.com/openalgz/ut"

SRC_URI="
	https://github.com/openalgz/ut/archive/refs/tags/v${PV}.tar.gz -> ut2-openalgz-${PV}.tar.gz"

S="${WORKDIR}/ut-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~arm64-macos ~ppc-macos ~x64-macos ~x64-solaris"
IUSE="test doc"

# REQUIRED_USE=""

RESTRICT="!test? ( test )"

# PROPERTIES=""

# DEPEND=""

# RDEPEND="${DEPEND}"

BDEPEND="
dev-build/cmake
"

PATCHES=(
	"${FILESDIR}/0003_rename_and_fix_installing.patch"
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_INSTALL_RULES=OFF
		-DBUILD_TESTING=$(usex test ON OFF)
	)
	cmake_src_configure
}

src_install() {
	if use doc; then
		einstalldocs
	fi

	cmake_src_install
}
