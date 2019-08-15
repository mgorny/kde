# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Library for accessing Google calendar and contact resources"
HOMEPAGE="https://cgit.kde.org/libkgapi.git"

LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="nls"

BDEPEND="
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
DEPEND="
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/kcalcore-${PVCUT}:5
	>=kde-apps/kcontacts-${PVCUT}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtwebengine-${QT_MINIMAL}:5[widgets]
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	dev-libs/cyrus-sasl:2
"
RDEPEND="${DEPEND}
	!kde-apps/kdepim-l10n
	!<kde-apps/kdepim-runtime-18.07.80:5
"
