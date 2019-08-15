# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
inherit kde5

DESCRIPTION="Library providing client-side support for web application remote blogging APIs"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlrpcclient-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/syndication-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/kcalcore-${PVCUT}:5
"
RDEPEND="${DEPEND}
	!kde-apps/kdepim-l10n
"
