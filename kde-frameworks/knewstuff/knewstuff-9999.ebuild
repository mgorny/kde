# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="false"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework for downloading and sharing additional application data"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/attica-${PVCUT}:5
	>=kde-frameworks/karchive-${PVCUT}:5
	>=kde-frameworks/kcompletion-${PVCUT}:5
	>=kde-frameworks/kconfig-${PVCUT}:5
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=kde-frameworks/ki18n-${PVCUT}:5
	>=kde-frameworks/kiconthemes-${PVCUT}:5
	>=kde-frameworks/kio-${PVCUT}:5
	>=kde-frameworks/kitemviews-${PVCUT}:5
	>=kde-frameworks/kservice-${PVCUT}:5
	>=kde-frameworks/ktextwidgets-${PVCUT}:5
	>=kde-frameworks/kwidgetsaddons-${PVCUT}:5
	>=kde-frameworks/kxmlgui-${PVCUT}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}
	>=kde-frameworks/kirigami-${PVCUT}:5
"
