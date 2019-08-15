# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_DESIGNERPLUGIN="true"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="An assortment of high-level widgets for common tasks"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="nls"

BDEPEND="
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
DEPEND="
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}"

src_test() {
	# bug 650216, 653186
	local myctestargs=( -E "(kdatecomboboxtest|ktooltipwidgettest)" )
	kde5_src_test
}
