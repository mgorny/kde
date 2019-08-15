# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
inherit kde5

DESCRIPTION="Libary for handling mail messages and newsgroup articles"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kcodecs-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
"
RDEPEND="${DEPEND}
	!kde-apps/kdepim-l10n
"
