# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Library for parsing RSS and Atom feeds"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	>=kde-frameworks/kcodecs-${PVCUT}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
"
DEPEND="${COMMON_DEPEND}
	test? (
		>=dev-qt/qtnetwork-${QT_MINIMAL}:5
		>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	)
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/syndication
"
