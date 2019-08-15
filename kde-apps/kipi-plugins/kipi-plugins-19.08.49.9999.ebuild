# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Plugins for the KDE Image Plugin Interface"
HOMEPAGE="https://userbase.kde.org/KIPI https://cgit.kde.org/kipi-plugins.git/"

LICENSE="GPL-2+"
KEYWORDS=""
IUSE="flashexport mediawiki +remotestorage vkontakte"

BDEPEND="sys-devel/gettext"
RDEPEND="
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/libkipi-${PVCUT}:5=
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtprintsupport-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	>=dev-qt/qtxmlpatterns-${QT_MINIMAL}:5
	flashexport? ( >=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5 )
	mediawiki? ( net-libs/libmediawiki:5 )
	remotestorage? ( >=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5 )
	vkontakte? ( net-libs/libkvkontakte:5 )
"
DEPEND="${RDEPEND}
	>=dev-qt/qtconcurrent-${QT_MINIMAL}:5
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package flashexport KF5Archive)
		$(cmake-utils_use_find_package mediawiki KF5MediaWiki)
		$(cmake-utils_use_find_package remotestorage KF5KIO)
		$(cmake-utils_use_find_package vkontakte KF5Vkontakte)
	)

	kde5_src_configure
}
