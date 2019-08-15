# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="KDE utility to translate DocBook XML files using gettext po files"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	sys-devel/gettext
"
RDEPEND="${DEPEND}"
