# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Data Model and Extraction System for Travel Reservation information"
HOMEPAGE="https://kde.org/applications/office/kontact/"

LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="+barcode pdf"

DEPEND="
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/kcalcore-${PVCUT}:5
	>=kde-apps/kcontacts-${PVCUT}:5
	>=kde-apps/kmime-${PVCUT}:5
	>=kde-apps/kpkpass-${PVCUT}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	sys-libs/zlib
	barcode? ( media-libs/zxing-cpp )
	pdf? ( app-text/poppler:=[qt5] )
"
RDEPEND="${DEPEND}
	!<kde-apps/kdepim-addons-18.07.80
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package barcode ZXing)
		$(cmake-utils_use_find_package pdf Poppler)
	)
	kde5_src_configure
}
