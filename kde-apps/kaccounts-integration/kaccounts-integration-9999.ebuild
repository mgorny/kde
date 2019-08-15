# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
VIRTUALDBUS_TEST="true"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
PLASMA_MINIMAL=5.15.5
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Administer web accounts for the sites and services across the Plasma desktop"
HOMEPAGE="https://community.kde.org/KTp"
LICENSE="LGPL-2.1"

KEYWORDS=""
IUSE=""

BDEPEND="
	sys-devel/gettext
"
COMMON_DEPEND="
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdeclarative-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	net-libs/accounts-qt
	>=net-libs/libaccounts-glib-1.21:=
	net-libs/signond
"
DEPEND="${COMMON_DEPEND}
	>=kde-frameworks/kcmutils-${FRAMEWORKS_MINIMAL}:5
	>=kde-plasma/kde-cli-tools-${PLASMA_MINIMAL}:5
"
RDEPEND="${COMMON_DEPEND}
	dev-util/intltool
"

# bug #549444
RESTRICT+=" test"
