# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_TEST="forceoptional"
PYTHON_COMPAT=( python3_{5,6,7} )
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5 python-single-r1

DESCRIPTION="Interface for doing mathematics and scientific computing"
HOMEPAGE="https://kde.org/applications/education/cantor https://edu.kde.org/cantor/"
KEYWORDS=""
IUSE="+analitza julia lua markdown postscript python qalculate R"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

# TODO Add Sage Mathematics Software backend (http://www.sagemath.org)
DEPEND="
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knewstuff-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kpty-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktexteditor-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/syntax-highlighting-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtprintsupport-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	>=dev-qt/qtxmlpatterns-${QT_MINIMAL}:5
	analitza? ( >=kde-apps/analitza-${PVCUT}:5 )
	julia? ( dev-lang/julia )
	lua? ( dev-lang/luajit:2 )
	markdown? ( >=app-text/discount-2.2.2 )
	qalculate? (
		sci-libs/cln
		sci-libs/libqalculate:=
	)
	postscript? ( app-text/libspectre )
	python? (
		${PYTHON_DEPS}
		>=dev-qt/qtdbus-${QT_MINIMAL}:5
	)
	R? ( dev-lang/R )
"
RDEPEND="${DEPEND}"

RESTRICT+=" test"

pkg_pretend() {
	kde5_pkg_pretend

	if ! has_version sci-mathematics/maxima && ! has_version sci-mathematics/octave && \
		! use analitza && ! use julia && ! use lua && ! use python && ! use qalculate && ! use R; then
		elog "You have decided to build ${PN} with no backend."
		elog "To have this application functional, please enable one of the backends via USE flag:"
		elog "    analitza, lua, python, qalculate, R"
		elog "Alternatively, install one of these:"
		elog "    # emerge sci-mathematics/maxima (bug #619534)"
		elog "    # emerge sci-mathematics/octave"
		elog "Experimental available USE flag:"
		elog "    julia (not stable, bug #613576)"
		elog
	fi

	if ! has_version virtual/latex-base; then
		elog "For LaTeX support:"
		elog "    # emerge virtual/latex-base"
	fi
}

pkg_setup() {
	use python && python-single-r1_pkg_setup
	kde5_pkg_setup
}

src_configure() {
	use julia && addpredict /proc/self/mem # bug 602894

	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_PythonLibs=ON
		$(cmake-utils_use_find_package analitza Analitza5)
		$(cmake-utils_use_find_package julia Julia)
		$(cmake-utils_use_find_package lua LuaJIT)
		$(cmake-utils_use_find_package markdown Discount)
		$(cmake-utils_use_find_package postscript LibSpectre)
		$(cmake-utils_use_find_package python PythonLibs3)
		$(cmake-utils_use_find_package qalculate Qalculate)
		$(cmake-utils_use_find_package R R)
	)
	kde5_src_configure
}
