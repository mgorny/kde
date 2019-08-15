# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Wrapper around exiv2 library"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE="+xmp"

DEPEND="
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=media-gfx/exiv2-0.25:=[xmp=]
"
RDEPEND="${DEPEND}"
