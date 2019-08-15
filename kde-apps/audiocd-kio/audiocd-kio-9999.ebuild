# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="kioslave for accessing audio CDs"
LICENSE="GPL-2+ handbook? ( FDL-1.2 )"
KEYWORDS=""
IUSE="flac vorbis"

DEPEND="
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcmutils-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/libkcddb-${PVCUT}:5
	>=kde-apps/libkcompactdisc-${PVCUT}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	media-sound/cdparanoia
	flac? ( >=media-libs/flac-1.1.2 )
	vorbis? (
		media-libs/libogg
		media-libs/libvorbis
	)
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-19.04.0-handbook.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package flac FLAC)
		$(cmake-utils_use_find_package vorbis OggVorbis)
	)

	kde5_src_configure
}
