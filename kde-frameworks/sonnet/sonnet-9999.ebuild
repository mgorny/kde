# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_DESIGNERPLUGIN="true"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework for providing spell-checking through abstraction of popular backends"
LICENSE="LGPL-2+ LGPL-2.1+"
KEYWORDS=""
IUSE="aspell +hunspell nls"

BDEPEND="
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
DEPEND="
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	aspell? ( app-text/aspell )
	hunspell? ( app-text/hunspell:= )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package aspell ASPELL)
		$(cmake-utils_use_find_package hunspell HUNSPELL)
	)

	kde5_src_configure
}

src_test() {
	# bugs: 680032
	local myctestargs=(
		-E "(sonnet-test_settings|sonnet-test_highlighter)"
	)

	kde5_src_test
}
