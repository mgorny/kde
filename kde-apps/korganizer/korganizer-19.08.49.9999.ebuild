# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_TEST="forceoptional"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Organizational assistant, providing calendars and other similar functionality"
HOMEPAGE="https://kde.org/applications/office/korganizer/"
LICENSE="GPL-2+ handbook? ( FDL-1.2+ )"
KEYWORDS=""
IUSE="X"

BDEPEND="
	test? ( >=kde-apps/akonadi-${PVCUT}:5[tools] )
"
COMMON_DEPEND="
	>=kde-frameworks/kcmutils-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcodecs-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kholidays-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemmodels-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemviews-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kjobwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knewstuff-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifications-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/akonadi-${PVCUT}:5
	>=kde-apps/akonadi-calendar-${PVCUT}:5
	>=kde-apps/akonadi-contacts-${PVCUT}:5
	>=kde-apps/akonadi-mime-${PVCUT}:5
	>=kde-apps/akonadi-notes-${PVCUT}:5
	>=kde-apps/akonadi-search-${PVCUT}:5
	>=kde-apps/calendarsupport-${PVCUT}:5
	>=kde-apps/eventviews-${PVCUT}:5
	>=kde-apps/incidenceeditor-${PVCUT}:5
	>=kde-apps/kcalcore-${PVCUT}:5
	>=kde-apps/kcalutils-${PVCUT}:5
	>=kde-apps/kcontacts-${PVCUT}:5
	>=kde-apps/kdepim-apps-libs-${PVCUT}:5
	>=kde-apps/kidentitymanagement-${PVCUT}:5
	>=kde-apps/kmailtransport-${PVCUT}:5
	>=kde-apps/kmime-${PVCUT}:5
	>=kde-apps/kontactinterface-${PVCUT}:5
	>=kde-apps/kpimtextedit-${PVCUT}:5
	>=kde-apps/libkdepim-${PVCUT}:5
	>=kde-apps/pimcommon-${PVCUT}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtmultimedia-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	X? (
		>=dev-qt/qtx11extras-${QT_MINIMAL}:5
		x11-libs/libX11
	)
"
DEPEND="${COMMON_DEPEND}
	>=kde-apps/kldap-${PVCUT}:5
	>=dev-qt/designer-${QT_MINIMAL}:5
	test? ( >=kde-apps/akonadi-${PVCUT}:5[sqlite] )
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepim-common-libs:4
	!kde-apps/kdepim-l10n
	>=kde-apps/kdepim-runtime-${PVCUT}:5
"

# testkodaymatrix is broken, akonadi* tests need DBus, bug #665686
RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X X11)
	)

	kde5_src_configure
}
