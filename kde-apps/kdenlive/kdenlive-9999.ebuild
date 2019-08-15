# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="optional"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Non-linear video editing suite by KDE"
HOMEPAGE="https://www.kdenlive.org/"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="freesound gles2 semantic-desktop share v4l"

BDEPEND="
	sys-devel/gettext
"
DEPEND="
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kbookmarks-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdeclarative-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kguiaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemviews-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kjobwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knewstuff-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifications-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifyconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/solid-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtconcurrent-${QT_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5[gles2=]
	>=dev-qt/qtmultimedia-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	dev-cpp/rttr
	>=media-libs/mlt-6.16.0[ffmpeg,frei0r,kdenlive,melt,qt5,sdl,xml]
	freesound? ( >=dev-qt/qtwebkit-5.212.0_pre20180120:5 )
	semantic-desktop? ( >=kde-frameworks/kfilemetadata-${FRAMEWORKS_MINIMAL}:5 )
	share? ( >=kde-frameworks/purpose-${FRAMEWORKS_MINIMAL}:5 )
	v4l? ( media-libs/libv4l )
"
RDEPEND="${DEPEND}
	>=dev-qt/qtquickcontrols-${QT_MINIMAL}:5
	virtual/ffmpeg[encode,sdl,X]
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package freesound Qt5WebKitWidgets)
		$(cmake-utils_use_find_package semantic-desktop KF5FileMetaData)
		$(cmake-utils_use_find_package share KF5Purpose)
		$(cmake-utils_use_find_package v4l LibV4L2)
	)

	kde5_src_configure
}

pkg_postinst() {
	kde5_pkg_postinst

	# Gentoo bug 603168
	if ! has_version "media-libs/mlt[fftw]" ; then
		elog "For 'Crop and Transform/Rotate and Shear' effect, please build media-libs/mlt with USE=fftw enabled."
	fi
}
