# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework providing assorted high-level user interface components"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtx11extras-${QT_MINIMAL}:5
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
	x11-libs/libxcb
"
