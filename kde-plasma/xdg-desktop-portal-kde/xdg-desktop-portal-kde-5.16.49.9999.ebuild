# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIRTUALX_REQUIRED="test"
FRAMEWORKS_MINIMAL=5.60.0
PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Backend implementation for xdg-desktop-portal that is using Qt/KDE Frameworks"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="screencast"

COMMON_DEPEND="
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifications-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtprintsupport-${QT_MINIMAL}:5[cups]
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	screencast? (
		dev-libs/glib:2
		media-libs/libepoxy
		media-libs/mesa[gbm]
		media-video/pipewire
	)
"
DEPEND="${COMMON_DEPEND}
	>=kde-frameworks/kwayland-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtconcurrent-${QT_MINIMAL}:5
"
RDEPEND="${COMMON_DEPEND}
	screencast? ( sys-apps/xdg-desktop-portal[screencast] )
	!screencast? ( sys-apps/xdg-desktop-portal )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package screencast GLIB2)
		$(cmake-utils_use_find_package screencast PipeWire)
		$(cmake-utils_use_find_package screencast GBM)
		$(cmake-utils_use_find_package screencast Epoxy)
	)
	kde5_src_configure
}
