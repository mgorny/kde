# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Provider for platform independent hardware discovery, abstraction and management"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="nls"

BDEPEND="
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
RDEPEND="
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	sys-fs/udisks:2
	virtual/libudev:=
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qtconcurrent-${QT_MINIMAL}:5 )
"

pkg_postinst() {
	kde5_pkg_postinst

	if [[ -z "${REPLACING_VERSIONS}" ]] && ! has_version "app-misc/media-player-info" ; then
		elog "For media player support, install app-misc/media-player-info"
	fi
}
