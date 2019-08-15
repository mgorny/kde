# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_EXAMPLES="true"
KDE_TEST="forceoptional-recursive"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Plugins for KDE Personal Information Management Suite"
HOMEPAGE="https://kde.org/applications/office/kontact/"

LICENSE="GPL-2+ LGPL-2.1+"
KEYWORDS=""
IUSE="importwizard markdown"

COMMON_DEPEND="
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/khtml-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/prison-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/syntax-highlighting-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/akonadi-${PVCUT}:5
	>=kde-apps/akonadi-contacts-${PVCUT}:5
	>=kde-apps/akonadi-notes-${PVCUT}:5
	>=kde-apps/calendarsupport-${PVCUT}:5
	>=kde-apps/eventviews-${PVCUT}:5
	>=kde-apps/grantleetheme-${PVCUT}:5
	>=kde-apps/incidenceeditor-${PVCUT}:5
	>=kde-apps/kcontacts-${PVCUT}:5
	>=kde-apps/kdepim-apps-libs-${PVCUT}:5
	>=kde-apps/kidentitymanagement-${PVCUT}:5
	>=kde-apps/kimap-${PVCUT}:5
	>=kde-apps/kitinerary-${PVCUT}:5
	>=kde-apps/kmailtransport-${PVCUT}:5
	>=kde-apps/kmime-${PVCUT}:5
	>=kde-apps/kontactinterface-${PVCUT}:5
	>=kde-apps/kpkpass-${PVCUT}:5
	>=kde-apps/libkdepim-${PVCUT}:5
	>=kde-apps/libkleo-${PVCUT}:5
	>=kde-apps/libksieve-${PVCUT}:5
	>=kde-apps/libktnef-${PVCUT}:5
	>=kde-apps/mailcommon-${PVCUT}:5
	>=kde-apps/messagelib-${PVCUT}:5
	>=kde-apps/pimcommon-${PVCUT}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	importwizard? ( >=kde-apps/akonadi-import-wizard-${PVCUT}:5 )
	markdown? ( app-text/discount )
"
DEPEND="${COMMON_DEPEND}
	>=app-crypt/gpgme-1.11.1[cxx,qt5]
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kaddressbook:4
	!kde-apps/kdepim-l10n
	!kde-apps/kmail:4
"

RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		-DKDEPIMADDONS_BUILD_EXAMPLES=$(usex examples)
		$(cmake-utils_use_find_package importwizard KPimImportWizard)
		$(cmake-utils_use_find_package markdown Discount)
	)

	kde5_src_configure
}

pkg_postinst() {
	kde5_pkg_postinst

	if [[ ${KDE_BUILD_TYPE} = live ]] && ! has_version "kde-misc/kregexpeditor" ; then
		elog "${PN} Sieve editor plugin can make use of kde-misc/kregexpeditor if installed."
	fi
}
