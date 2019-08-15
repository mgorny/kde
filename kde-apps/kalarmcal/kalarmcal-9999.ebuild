# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Client library to access and handling of KAlarm calendar data"
LICENSE="GPL-2+ LGPL-2.1+"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kholidays-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/akonadi-${PVCUT}:5
	>=kde-apps/kcalcore-${PVCUT}:5
	>=kde-apps/kcalutils-${PVCUT}:5
	>=kde-apps/kidentitymanagement-${PVCUT}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
"
DEPEND="${COMMON_DEPEND}
	test? ( >=dev-qt/qtdbus-${QT_MINIMAL}:5 )
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepim-l10n
	!<kde-apps/kdepim-runtime-18.03.80
"

src_test() {
	LANG="C" kde5_src_test #bug 665626
}
