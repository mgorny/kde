# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
KMNAME="ktnef"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Library for handling TNEF data"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/kcalcore-${PVCUT}:5
	>=kde-apps/kcalutils-${PVCUT}:5
	>=kde-apps/kcontacts-${PVCUT}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}
	!kde-apps/kdepim-l10n
"
