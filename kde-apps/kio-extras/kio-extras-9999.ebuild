# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_TEST="optional"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="KIO plugins present a filesystem-like view of arbitrary data"
HOMEPAGE="https://cgit.kde.org/kio-extras.git"
KEYWORDS=""
IUSE="activities +man mtp openexr phonon samba +sftp taglib"

BDEPEND="
	man? ( dev-util/gperf )
"
DEPEND="
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5[bzip2,lzma]
	>=kde-frameworks/kbookmarks-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcodecs-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdnssd-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kguiaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kpty-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/solid-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/syntax-highlighting-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	activities? (
		>=kde-frameworks/kactivities-${FRAMEWORKS_MINIMAL}:5
		>=dev-qt/qtsql-${QT_MINIMAL}:5
	)
	man? ( >=kde-frameworks/khtml-${FRAMEWORKS_MINIMAL}:5 )
	mtp? ( >=media-libs/libmtp-1.1.16:= )
	openexr? ( media-libs/openexr:= )
	phonon? ( media-libs/phonon[qt5(+)] )
	samba? ( net-fs/samba[client] )
	sftp? ( net-libs/libssh:=[sftp] )
	taglib? ( >=media-libs/taglib-1.11.1 )
"
RDEPEND="${DEPEND}
	>=kde-frameworks/kded-${FRAMEWORKS_MINIMAL}:5
"

# requires running kde environment
RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package activities KF5Activities)
		$(cmake-utils_use_find_package man Gperf)
		$(cmake-utils_use_find_package mtp Mtp)
		$(cmake-utils_use_find_package openexr OpenEXR)
		$(cmake-utils_use_find_package phonon Phonon4Qt5)
		$(cmake-utils_use_find_package samba Samba)
		$(cmake-utils_use_find_package sftp libssh)
		$(cmake-utils_use_find_package taglib Taglib)
	)

	kde5_src_configure
}
