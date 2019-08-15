# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Plasma filemanager focusing on usability"
HOMEPAGE="https://kde.org/applications/system/dolphin https://userbase.kde.org/Dolphin"
KEYWORDS=""
IUSE="activities semantic-desktop"

DEPEND="
	>=kde-frameworks/kbookmarks-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcmutils-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcodecs-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kinit-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemviews-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kjobwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knewstuff-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifications-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/solid-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtconcurrent-${QT_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	media-libs/phonon[qt5(+)]
	activities? ( >=kde-frameworks/kactivities-${FRAMEWORKS_MINIMAL}:5 )
	semantic-desktop? (
		>=kde-frameworks/baloo-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/kfilemetadata-${FRAMEWORKS_MINIMAL}:5
		>=kde-apps/baloo-widgets-${PVCUT}:5
	)
"
RDEPEND="${DEPEND}
	>=kde-apps/kio-extras-${PVCUT}:5
"

RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package activities KF5Activities)
		$(cmake-utils_use_find_package semantic-desktop KF5Baloo)
		$(cmake-utils_use_find_package semantic-desktop KF5BalooWidgets)
		$(cmake-utils_use_find_package semantic-desktop KF5FileMetaData)
	)

	kde5_src_configure
}

pkg_postinst() {
	kde5_pkg_postinst

	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		has_version "kde-apps/ark:${SLOT}" || \
			elog "For compress/extract and other actions install kde-apps/ark:${SLOT}"

		has_version "kde-apps/kleopatra:${SLOT}" || \
			elog "For crypto actions install kde-apps/kleopatra:${SLOT}"

		has_version "kde-apps/ffmpegthumbs:${SLOT}" || \
			elog "For video file thumbnails install kde-apps/ffmpegthumbs:${SLOT}"

		has_version "kde-apps/thumbnailers:${SLOT}" || \
			elog "For graphics file thumbnails install kde-apps/thumbnailers:${SLOT}"

		has_version "kde-frameworks/purpose:${SLOT}" || \
			elog "For 'Share' context menu actions install kde-frameworks/purpose:${SLOT}"
	fi
}
