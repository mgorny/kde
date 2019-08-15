# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework for manipulating strings using various encodings"
LICENSE="GPL-2+ LGPL-2+"
KEYWORDS=""
IUSE="nls"

BDEPEND="
	dev-util/gperf
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
