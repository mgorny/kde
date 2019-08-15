# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KMNAME="kdegraphics-thumbnailers"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Thumbnail generators for PDF/PS and RAW files"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE="raw"

DEPEND="
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	raw? (
		>=kde-apps/libkdcraw-${PVCUT}:5
		>=kde-apps/libkexiv2-${PVCUT}:5
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package raw KF5KExiv2)
		$(cmake-utils_use_find_package raw KF5KDcraw)
	)

	kde5_src_configure
}
