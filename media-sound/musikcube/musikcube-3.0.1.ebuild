# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Excellent terminal music player, support almost every known sound system."
HOMEPAGE="https://github.com/clangen/${PN}"
SRC_URI="https://github.com/clangen/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="~amd64 ~*"
IUSE="+alsa +libopenmpt pipewire pulseaudio +mpris portaudio sndio systemd elogind basu"

REQUIRED_USE="
	mpris? ( ^^ ( systemd elogind basu ) )
"

DEPEND="
	net-libs/libmicrohttpd
	sys-libs/ncurses
	media-libs/libogg
	media-video/ffmpeg
	sys-libs/zlib
	media-libs/libvorbis
	net-misc/curl
	media-sound/lame
	dev-libs/libev
	media-libs/taglib
	libopenmpt? (
		media-libs/libopenmpt
	)
	mpris? (
		|| (
			elogind? ( >=sys-auth/elogind-239 )
			systemd? ( sys-apps/systemd )
			basu? ( sys-libs/basu )

		)

	)
	pipewire? (
		media-video/pipewire
	)
	portaudio? (
		media-libs/portaudio
	)
	pulseaudio? (
		media-sound/pulseaudio
	)
	sndio? (
		media-sound/sndio
	)
	alsa? (
		media-libs/alsa-lib
	)
"

RDEPEND="${DEPEND}"

BDEPEND="
	dev-util/cmake
"
PATCHES=(
	"${FILESDIR}/tinfow.patch"
)

src_configure() {
	local mycmakeargs=(
		# -DENABLE_ALSA=$(usex alsa true false)
		-DENABLE_PIPEWIRE=$(usex pipewire true false)
		# -DENABLE_PULSEAUDIO=$(usex pulseaudio true false)
		# -DENABLE_MPRIS=$(usex mpris true false)

		if use mpris then
			-DUSE_ELOGIND=$(usex elogind true false)
			-DUSE_BASU=$(usex basu true false)
		fi
		# -DENABLE_OPENMPT=$(usex libopenmpt true false)
		# -DENABLE_SNDIO=$(usex sndio true false )
		# -DENABLE_SERVER=$(usex server true false)
		# -DENABLE_BUNDLED_TAGLIB=false
		-DBUILD_STANDALONE=false

	)
	cmake_src_configure
}

