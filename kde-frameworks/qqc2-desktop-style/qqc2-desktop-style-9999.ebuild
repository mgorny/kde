# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_QTHELP="false"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Style for QtQuickControls 2 that uses QWidget's QStyle for painting"
KEYWORDS=""
LICENSE="|| ( GPL-2+ LGPL-3+ )"
IUSE=""

DEPEND="
	>=kde-frameworks/kconfigwidgets-${PVCUT}:5
	>=kde-frameworks/kiconthemes-${PVCUT}:5
	>=kde-frameworks/kirigami-${PVCUT}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5=
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}
	>=dev-qt/qtgraphicaleffects-${QT_MINIMAL}:5
	>=dev-qt/qtquickcontrols2-${QT_MINIMAL}:5
"
