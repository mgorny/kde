# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework for syntax highlighting"
LICENSE="LGPL-2+ LGPL-2.1+"
KEYWORDS=""
IUSE="nls"

BDEPEND="
	dev-lang/perl
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
DEPEND="
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtxmlpatterns-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}"

src_install() {
	kde5_src_install
	dobin "${BUILD_DIR}"/bin/katehighlightingindexer
}
