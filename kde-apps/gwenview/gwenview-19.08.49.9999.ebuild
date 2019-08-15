# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_TEST="true"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Image viewer by KDE"
HOMEPAGE="
	https://kde.org/applications/graphics/gwenview/
	https://userbase.kde.org/Gwenview
"

LICENSE="GPL-2+ handbook? ( FDL-1.2 )"
KEYWORDS=""
IUSE="activities fits kipi +mpris raw semantic-desktop share X"

# requires running environment
RESTRICT+=" test"

COMMON_DEPEND="
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemmodels-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemviews-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kjobwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifications-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/solid-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtopengl-${QT_MINIMAL}:5
	>=dev-qt/qtprintsupport-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	media-gfx/exiv2:=
	media-libs/lcms:2
	media-libs/libpng:0=
	media-libs/phonon[qt5(+)]
	virtual/jpeg:0
	activities? ( >=kde-frameworks/kactivities-${FRAMEWORKS_MINIMAL}:5 )
	fits? ( sci-libs/cfitsio )
	kipi? ( >=kde-apps/libkipi-${PVCUT}:5= )
	mpris? ( >=dev-qt/qtdbus-${QT_MINIMAL}:5 )
	raw? ( >=kde-apps/libkdcraw-${PVCUT}:5 )
	semantic-desktop? (
		>=kde-frameworks/baloo-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/kfilemetadata-${FRAMEWORKS_MINIMAL}:5
	)
	share? ( >=kde-frameworks/purpose-${FRAMEWORKS_MINIMAL}:5 )
	X? (
		>=dev-qt/qtx11extras-${QT_MINIMAL}:5
		x11-libs/libX11
	)
"
DEPEND="${COMMON_DEPEND}
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtconcurrent-${QT_MINIMAL}:5
"
RDEPEND="${COMMON_DEPEND}
	>=kde-frameworks/kimageformats-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtimageformats-${QT_MINIMAL}:5
	kipi? ( >=kde-apps/kipi-plugins-${PVCUT}:5 )
"

src_prepare() {
	kde5_src_prepare
	if ! use mpris; then
		# FIXME: upstream a better solution
		sed -e "/set(HAVE_QTDBUS/s/\${Qt5DBus_FOUND}/0/" -i CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package activities KF5Activities)
		$(cmake-utils_use_find_package fits CFitsio)
		$(cmake-utils_use_find_package kipi KF5Kipi)
		$(cmake-utils_use_find_package raw KF5KDcraw)
		$(cmake-utils_use_find_package share KF5Purpose)
		$(cmake-utils_use_find_package X X11)
	)

	if use semantic-desktop; then
		mycmakeargs+=( -DGWENVIEW_SEMANTICINFO_BACKEND=Baloo )
	else
		mycmakeargs+=( -DGWENVIEW_SEMANTICINFO_BACKEND=None )
	fi

	kde5_src_configure
}

pkg_postinst() {
	kde5_pkg_postinst

	if [[ -z "${REPLACING_VERSIONS}" ]] && ! has_version kde-apps/svgpart:${SLOT} ; then
		elog "For SVG support, install kde-apps/svgpart:${SLOT}"
	fi
}
