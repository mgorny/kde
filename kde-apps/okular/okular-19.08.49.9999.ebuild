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

DESCRIPTION="Universal document viewer based on KDE Frameworks"
HOMEPAGE="https://okular.kde.org https://kde.org/applications/graphics/okular"
KEYWORDS=""
IUSE="chm crypt djvu epub +image-backend markdown mobi mobile +pdf plucker +postscript share speech +tiff"

DEPEND="
	>=kde-frameworks/kactivities-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kbookmarks-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kjs-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kpty-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwallet-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/threadweaver-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtprintsupport-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	media-libs/freetype
	media-libs/phonon[qt5(+)]
	sys-libs/zlib
	chm? (
		>=kde-frameworks/khtml-${FRAMEWORKS_MINIMAL}:5
		dev-libs/chmlib
	)
	crypt? ( app-crypt/qca:2[qt5(+)] )
	djvu? ( app-text/djvu )
	epub? ( app-text/ebook-tools )
	image-backend? (
		>=kde-apps/libkexiv2-${PVCUT}:5
		>=dev-qt/qtgui-${QT_MINIMAL}:5[gif,jpeg,png]
	)
	markdown? ( app-text/discount )
	mobi? ( >=kde-apps/kdegraphics-mobipocket-${PVCUT}:5 )
	pdf? ( app-text/poppler[qt5] )
	plucker? ( virtual/jpeg:0 )
	postscript? ( app-text/libspectre )
	share? ( >=kde-frameworks/purpose-${FRAMEWORKS_MINIMAL}:5 )
	speech? ( >=dev-qt/qtspeech-${QT_MINIMAL}:5 )
	tiff? ( media-libs/tiff:0 )
"
RDEPEND="${DEPEND}
	image-backend? ( >=kde-frameworks/kimageformats-${FRAMEWORKS_MINIMAL}:5 )
	mobile? (
		>=kde-frameworks/kirigami-${FRAMEWORKS_MINIMAL}:5
		>=dev-qt/qtquickcontrols-${QT_MINIMAL}:5
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-18.08.0-tests.patch"
	"${FILESDIR}/${PN}-18.12.0-tests.patch"
)

src_prepare() {
	kde5_src_prepare
	use mobile || cmake_comment_add_subdirectory mobile
	use test || cmake_comment_add_subdirectory conf/autotests
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package chm CHM)
		$(cmake-utils_use_find_package crypt Qca-qt5)
		$(cmake-utils_use_find_package djvu DjVuLibre)
		$(cmake-utils_use_find_package epub EPub)
		$(cmake-utils_use_find_package image-backend KF5KExiv2)
		$(cmake-utils_use_find_package markdown Discount)
		$(cmake-utils_use_find_package mobi QMobipocket)
		$(cmake-utils_use_find_package pdf Poppler)
		$(cmake-utils_use_find_package plucker JPEG)
		$(cmake-utils_use_find_package postscript LibSpectre)
		$(cmake-utils_use_find_package share KF5Purpose)
		$(cmake-utils_use_find_package speech Qt5TextToSpeech)
		$(cmake-utils_use_find_package tiff TIFF)
	)

	kde5_src_configure
}

src_test() {
	# mainshelltest hangs, chmgeneratortest fails, bug #603116
	# parttest hangs, bug #641728
	local myctestargs=(
		-E "(mainshelltest|chmgeneratortest|parttest)"
	)

	kde5_src_test
}
