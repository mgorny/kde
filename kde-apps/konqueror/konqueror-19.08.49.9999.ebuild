# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional" # not optional until !kdelibs4support
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
PLASMA_MINIMAL=5.15.5
QT_MINIMAL=5.12.3
inherit flag-o-matic kde5

DESCRIPTION="Web browser and file manager based on KDE Frameworks"
HOMEPAGE="
	https://kde.org/applications/internet/konqueror/
	https://konqueror.org/
"
KEYWORDS=""
IUSE="activities speech tidy +webengine X"
# 4 of 4 tests fail. Last checked for 4.0.3
RESTRICT+=" test"

COMMON_DEPEND="
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kbookmarks-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcmutils-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcodecs-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdelibs4support-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdesu-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kguiaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/khtml-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemviews-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kjobwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwallet-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	sys-libs/zlib
	speech? ( >=dev-qt/qtspeech-${QT_MINIMAL}:5 )
	tidy? ( app-text/tidy-html5 )
	webengine? ( >=dev-qt/qtwebengine-${QT_MINIMAL}:5[widgets] )
	X? ( >=dev-qt/qtx11extras-${QT_MINIMAL}:5 )
"
DEPEND="${COMMON_DEPEND}
	activities? ( >=kde-frameworks/kactivities-${FRAMEWORKS_MINIMAL}:5 )
"
RDEPEND="${COMMON_DEPEND}
	>=kde-apps/kfind-${PVCUT}:5
	>=kde-plasma/kde-cli-tools-${PLASMA_MINIMAL}:5
	!webengine? ( kde-misc/kwebkitpart:5 )
"

src_prepare() {
	[[ ${CHOST} == *-solaris* ]] && append-ldflags -lmalloc

	if ! use webengine; then
		punt_bogus_dep Qt5 WebEngineWidgets
		cmake_comment_add_subdirectory webenginepart
	fi

	kde5_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package activities KF5Activities)
		$(cmake-utils_use_find_package speech Qt5TextToSpeech)
		$(cmake-utils_use_find_package tidy LibTidy)
		$(cmake-utils_use_find_package X X11)
	)
	kde5_src_configure
}

pkg_postinst() {
	kde5_pkg_postinst

	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		if ! has_version kde-apps/keditbookmarks:${SLOT} ; then
			elog "For bookmarks support, install keditbookmarks:"
			elog "kde-apps/keditbookmarks:${SLOT}"
		fi

		if ! has_version kde-apps/dolphin:${SLOT} ; then
			elog "If you want to use konqueror as a filemanager, install the dolphin kpart:"
			elog "kde-apps/dolphin:${SLOT}"
		fi

		if ! has_version kde-apps/svg:${SLOT} ; then
			elog "For konqueror to view SVGs, install the svg kpart:"
			elog "kde-apps/svgpart:${SLOT}"
		fi

		if ! has_version virtual/jre ; then
			elog "To use Java on webpages install virtual/jre."
		fi
	fi
}
