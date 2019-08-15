# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional-recursive"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="KDE library for mathematical features"
KEYWORDS=""
IUSE="eigen nls"

BDEPEND="
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
DEPEND="
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5[-gles2]
	>=dev-qt/qtprintsupport-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	eigen? ( dev-cpp/eigen:3 )
"
RDEPEND="${DEPEND}"

src_prepare() {
	kde5_src_prepare

	if ! use test; then
		sed -i \
			-e "/add_subdirectory(examples)/ s/^/#DONT/" \
			analitzaplot/CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package eigen Eigen3)
	)

	kde5_src_configure
}
