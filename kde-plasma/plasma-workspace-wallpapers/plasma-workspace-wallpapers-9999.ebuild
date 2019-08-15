# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_AUTODEPS="false"
KDE_DEBUG="false"
FRAMEWORKS_MINIMAL=5.60.0
PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Additional wallpapers for the Plasma workspace"
KEYWORDS=""
IUSE=""

BDEPEND="
	>=kde-frameworks/extra-cmake-modules-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtcore-${QT_MINIMAL}:5
"
