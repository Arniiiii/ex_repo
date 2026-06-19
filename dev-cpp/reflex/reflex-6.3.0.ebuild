# Copyright 2026 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

DESCRIPTION="Best regex library"
HOMEPAGE="https://www.genivia.com/doc/reflex/html/"
SRC_URI="https://github.com/Genivia/RE-flex/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/RE-flex-${PV}"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64"
