# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework for reading and writing configuration"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="dbus nls"

BDEPEND="
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
RDEPEND="
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	dbus? ( >=dev-qt/qtdbus-${QT_MINIMAL}:5 )
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qtconcurrent-${QT_MINIMAL}:5 )
"

# bug 560086
RESTRICT+=" test"

DOCS=( DESIGN docs/DESIGN.kconfig docs/options.md )

src_configure() {
	local mycmakeargs=(
		-DKCONFIG_USE_DBUS=$(usex dbus)
	)
	kde5_src_configure
}
