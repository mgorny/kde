# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Application to take pictures and videos from your webcam by KDE"
HOMEPAGE="https://userbase.kde.org/Kamoso"

LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemviews-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/purpose-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	dev-libs/glib:2
	media-libs/gst-plugins-base:1.0
	virtual/opengl
"
RDEPEND="${DEPEND}
	>=kde-frameworks/kirigami-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtquickcontrols2-${QT_MINIMAL}:5
	media-plugins/gst-plugins-jpeg:1.0
	media-plugins/gst-plugins-libpng:1.0
	media-plugins/gst-plugins-meta:1.0[alsa,theora,vorbis,v4l]
"

RESTRICT+=" test" # bug 653674
