# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

FRAMEWORKS_MINIMAL=5.60.0
PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Breeze visual style for the Plasma desktop"
HOMEPAGE="https://cgit.kde.org/breeze.git"
KEYWORDS=""
IUSE="wayland X"

RDEPEND="
	>=kde-frameworks/frameworkintegration-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcmutils-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kguiaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-plasma/kdecoration-${PVCUT}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	sci-libs/fftw:3.0=
	wayland? ( >=kde-frameworks/kwayland-${FRAMEWORKS_MINIMAL}:5 )
	X? (
		>=dev-qt/qtx11extras-${QT_MINIMAL}:5
		x11-libs/libxcb
	)
"
DEPEND="${RDEPEND}
	>=kde-frameworks/kpackage-${FRAMEWORKS_MINIMAL}:5
"
PDEPEND="
	>=kde-frameworks/breeze-icons-${FRAMEWORKS_MINIMAL}:5
	>=kde-plasma/kde-cli-tools-${PVCUT}:5
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package wayland KF5Wayland)
		$(cmake-utils_use_find_package X XCB)
	)
	kde5_src_configure
}
