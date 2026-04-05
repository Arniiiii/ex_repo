# Copyright 2025 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="C library that may be linked into a C/C++ program to produce symbolic backtraces"
HOMEPAGE="https://github.com/ianlancetaylor/libbacktrace"

EGIT_REPO_URI="https://github.com/ianlancetaylor/libbacktrace.git"
EGIT_BRANCH="master"
inherit git-r3 autotools multilib-minimal flag-o-matic


LICENSE="BSD"
SLOT="0"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

BDEPEND="
	test? (
		app-arch/xz-utils
		virtual/zlib
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
