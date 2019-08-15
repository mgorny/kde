# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5 flag-o-matic

DESCRIPTION="Periodic table of the elements"
HOMEPAGE="https://kde.org/applications/education/kalzium https://edu.kde.org/kalzium/"
KEYWORDS=""
IUSE="editor solver"

DEPEND="
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/khtml-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemviews-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kplotting-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kunitconversion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtscript-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	editor? (
		>=kde-frameworks/knewstuff-${FRAMEWORKS_MINIMAL}:5
		>=dev-qt/qtopengl-${QT_MINIMAL}:5
		dev-cpp/eigen:3
		sci-chemistry/openbabel
		sci-libs/avogadrolibs[qt5]
	)
	solver? ( dev-ml/facile[ocamlopt] )
"
RDEPEND="${DEPEND}
	sci-chemistry/chemical-mime-data
"

src_configure(){
	# Fix missing finite()
	[[ ${CHOST} == *-solaris* ]] && append-cppflags -DHAVE_IEEEFP_H

	local mycmakeargs=(
		$(cmake-utils_use_find_package editor Eigen3)
		$(cmake-utils_use_find_package editor AvogadroLibs)
		$(cmake-utils_use_find_package editor OpenBabel2)
		$(cmake-utils_use_find_package solver OCaml)
		$(cmake-utils_use_find_package solver Libfacile)
	)

	kde5_src_configure
}
