# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_AUTODEPS="false"
KDE_DEBUG="false"
KDE_QTHELP="false"
KDE_TEST="true"
KMNAME="oxygen-icons5"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Oxygen SVG icon theme"
LICENSE="LGPL-3"
KEYWORDS=""
IUSE=""

BDEPEND="
	>=kde-frameworks/extra-cmake-modules-${PVCUT}:5
	>=dev-qt/qtcore-${QT_MINIMAL}:5
	test? ( app-misc/fdupes )
"
DEPEND="test? ( >=dev-qt/qttest-${QT_MINIMAL}:5 )"
RDEPEND="
	!kde-frameworks/oxygen-icons:4
"
