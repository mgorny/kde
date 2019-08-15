# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="optional" # see src/apps/marble-kde/CMakeLists.txt
KDE_SUBSLOT="true"
KDE_TEST="forceoptional"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Virtual Globe and World Atlas to learn more about Earth"
HOMEPAGE="https://marble.kde.org/"

KEYWORDS=""
IUSE="aprs +dbus designer gps +kde nls phonon +geolocation shapefile +webengine"

# FIXME (new package): libwlocate, WLAN-based geolocation
BDEPEND="
	aprs? ( dev-lang/perl )
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
DEPEND="
	>=dev-qt/qtconcurrent-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtprintsupport-${QT_MINIMAL}:5
	>=dev-qt/qtsql-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	aprs? ( >=dev-qt/qtserialport-${QT_MINIMAL}:5 )
	dbus? ( >=dev-qt/qtdbus-${QT_MINIMAL}:5 )
	designer? ( >=dev-qt/designer-${QT_MINIMAL}:5 )
	geolocation? ( >=dev-qt/qtpositioning-${QT_MINIMAL}:5 )
	gps? ( sci-geosciences/gpsd )
	kde? (
		>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/knewstuff-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/krunner-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/kwallet-${FRAMEWORKS_MINIMAL}:5
	)
	phonon? ( media-libs/phonon[qt5(+)] )
	shapefile? ( sci-libs/shapelib:= )
	webengine? ( >=dev-qt/qtwebengine-${QT_MINIMAL}:5[widgets] )
"
RDEPEND="${DEPEND}"

# bug 588320
RESTRICT+=" test"

src_prepare() {
	if use kde; then
		sed -e "/add_subdirectory(marble-qt)/ s/^/#DONT/" \
			-i src/apps/CMakeLists.txt \
			|| die "Failed to disable marble-qt"
	fi

	kde5_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package aprs Perl)
		$(cmake-utils_use_find_package geolocation Qt5Positioning)
		-DBUILD_MARBLE_TESTS=$(usex test)
		-DWITH_DESIGNER_PLUGIN=$(usex designer)
		-DWITH_libgps=$(usex gps)
		-DWITH_KF5=$(usex kde)
		-DWITH_Phonon4Qt5=$(usex phonon)
		-DWITH_libshp=$(usex shapefile)
		$(cmake-utils_use_find_package webengine Qt5WebEngine)
		$(cmake-utils_use_find_package webengine Qt5WebEngineWidgets)
		-DWITH_libwlocate=OFF
		# bug 608890
		-DKDE_INSTALL_CONFDIR="/etc/xdg"
	)
	kde5_src_configure
}
