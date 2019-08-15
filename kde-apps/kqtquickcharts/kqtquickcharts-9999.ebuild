# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Qt Quick plugin for beautiful and interactive charts"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}"
