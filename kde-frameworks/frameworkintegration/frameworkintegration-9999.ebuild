# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_QTHELP="false"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework for integrating Qt applications with KDE Plasma workspaces"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="appstream X"

DEPEND="
	>=kde-frameworks/kconfig-${PVCUT}:5
	>=kde-frameworks/kconfigwidgets-${PVCUT}:5
	>=kde-frameworks/ki18n-${PVCUT}:5
	>=kde-frameworks/kiconthemes-${PVCUT}:5
	>=kde-frameworks/knewstuff-${PVCUT}:5
	>=kde-frameworks/knotifications-${PVCUT}:5
	>=kde-frameworks/kpackage-${PVCUT}:5
	>=kde-frameworks/kwidgetsaddons-${PVCUT}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	appstream? (
		app-admin/packagekit-qt
		dev-libs/appstream[qt5]
	)
	X? (
		>=dev-qt/qtx11extras-${QT_MINIMAL}:5
		x11-libs/libxcb
	)
"
RDEPEND="${DEPEND}"

# requires running kde environment
RESTRICT+=" test"

src_prepare() {
	punt_bogus_dep Qt5 DBus
	kde5_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package appstream AppStreamQt)
		$(cmake-utils_use_find_package appstream packagekitqt5)
		$(cmake-utils_use_find_package X XCB)
	)

	kde5_src_configure
}
