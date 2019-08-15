# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_QTHELP="false"
KDE_TEST="true"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Library to determine holidays and other special events for a geographical region"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="nls"

BDEPEND="
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
DEPEND="
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}
	!kde-apps/kholidays:5
"

src_test() {
	# bug 624214
	mkdir -p "${HOME}/.local/share/kf5/libkholidays" || die
	cp -r "${S}/holidays/plan2" "${HOME}/.local/share/kf5/libkholidays/" || die
	kde5_src_test
}
