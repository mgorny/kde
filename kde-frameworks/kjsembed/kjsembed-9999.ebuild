# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="optional"
KDE_QTHELP="false"
KDE_TEST="false"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework binding JavaScript objects to QObjects"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=kde-frameworks/ki18n-${PVCUT}:5
	>=kde-frameworks/kjs-${PVCUT}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
"
DEPEND="${RDEPEND}
	>=dev-qt/designer-${QT_MINIMAL}:5
"
