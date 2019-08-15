# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Library to deal with Apple Wallet pass files"
HOMEPAGE="https://kde.org/applications/office/kontact/"

LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}
	!<kde-apps/kdepim-addons-18.07.80
"
