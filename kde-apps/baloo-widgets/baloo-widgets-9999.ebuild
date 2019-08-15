# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Widget library for baloo"
LICENSE="LGPL-2+ LGPL-2.1+ || ( LGPL-2.1 LGPL-3 )"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/baloo-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kfilemetadata-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}"

RESTRICT+=" test"
