# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_QTHELP="false"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework providing additional format plugins for Qt's image I/O system"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="eps openexr"

DEPEND="
	>=kde-frameworks/karchive-${PVCUT}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	eps? ( >=dev-qt/qtprintsupport-${QT_MINIMAL}:5 )
	openexr? (
		media-libs/ilmbase:=
		media-libs/openexr:=
	)
"
RDEPEND="${DEPEND}"

DOCS=( src/imageformats/AUTHORS )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package eps Qt5PrintSupport)
		$(cmake-utils_use_find_package openexr OpenEXR)
	)

	kde5_src_configure
}
