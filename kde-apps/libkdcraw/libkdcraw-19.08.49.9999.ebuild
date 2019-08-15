# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Digital camera raw image library wrapper"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=media-libs/libraw-0.16:=
"
RDEPEND="${DEPEND}"
