# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_TEST="true"
PYTHON_COMPAT=( python2_7 )
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit python-single-r1 kde5

DESCRIPTION="KDE Interactive Geometry tool"
HOMEPAGE="https://kde.org/applications/education/kig https://edu.kde.org/kig/"
KEYWORDS=""
IUSE="geogebra scripting"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtprintsupport-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	geogebra? ( >=dev-qt/qtxmlpatterns-${QT_MINIMAL}:5 )
	scripting? ( >=dev-libs/boost-1.48:=[python,${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}
	>=kde-frameworks/ktexteditor-${FRAMEWORKS_MINIMAL}:5
"

PATCHES=( "${FILESDIR}/${PN}-4.12.0-boostpython.patch" )

pkg_setup() {
	python-single-r1_pkg_setup
	kde5_pkg_setup
}

src_prepare() {
	kde5_src_prepare
	python_fix_shebang .
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package geogebra Qt5XmlPatterns)
		$(cmake-utils_use_find_package scripting BoostPython)
	)

	kde5_src_configure
}
