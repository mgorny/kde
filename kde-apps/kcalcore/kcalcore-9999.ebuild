# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Library for handling calendar data"
LICENSE="GPL-2+ test? ( LGPL-3+ )"
KEYWORDS=""
IUSE=""

BDEPEND="
	sys-devel/bison
"
DEPEND="
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	dev-libs/libical:=
"
RDEPEND="${DEPEND}"

RESTRICT+=" test" # multiple tests fail or hang indefinitely
