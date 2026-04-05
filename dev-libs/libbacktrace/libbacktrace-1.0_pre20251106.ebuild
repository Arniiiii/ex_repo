# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools multilib-minimal flag-o-matic

DESCRIPTION="C library that may be linked into a C/C++ program to produce symbolic backtraces"
HOMEPAGE="https://github.com/ianlancetaylor/libbacktrace"

COMMITHASH="b9e40069c0b47a722286b94eb5231f7f05c08713"

SRC_URI="https://github.com/ianlancetaylor/libbacktrace/archive/${COMMITHASH}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${COMMITHASH}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

BDEPEND="
	test? (
		app-arch/xz-utils
		sys-libs/zlib
	)
"

src_prepare() {
	default

	eautoreconf
}

multilib_src_configure() {
	# tests are failing with LTO.
	# https://github.com/ianlancetaylor/libbacktrace/issues/152
	filter-lto

	ECONF_SOURCE="${S}" econf --enable-shared \
		$(use_enable static{-libs,})
}

multilib_src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
