# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="false"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework for notifying the user of an event"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="dbus nls phonon speech X"

BDEPEND="
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
RDEPEND="
	>=kde-frameworks/kcodecs-${PVCUT}:5
	>=kde-frameworks/kconfig-${PVCUT}:5
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=kde-frameworks/kwindowsystem-${PVCUT}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	dbus? ( dev-libs/libdbusmenu-qt[qt5(+)] )
	!phonon? ( media-libs/libcanberra )
	phonon? ( media-libs/phonon[qt5(+)] )
	speech? ( >=dev-qt/qtspeech-${QT_MINIMAL}:5 )
	X? (
		>=dev-qt/qtx11extras-${QT_MINIMAL}:5
		x11-libs/libX11
		x11-libs/libXtst
	)
"
DEPEND="${RDEPEND}
	X? ( x11-base/xorg-proto )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package dbus dbusmenu-qt5)
		$(cmake-utils_use_find_package !phonon Canberra)
		$(cmake-utils_use_find_package speech Qt5TextToSpeech)
		$(cmake-utils_use_find_package X X11)
	)

	kde5_src_configure
}
