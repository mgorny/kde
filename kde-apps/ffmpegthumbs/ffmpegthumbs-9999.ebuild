# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="FFmpeg based thumbnail generator for video files"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE="libav"

BDEPEND="
	virtual/pkgconfig
"
DEPEND="
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	libav? ( media-video/libav:= )
	!libav? ( media-video/ffmpeg:0= )
"
RDEPEND="${DEPEND}"
