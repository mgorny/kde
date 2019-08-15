# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework for getting the usage statistics collected by the activities service"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtsql-${QT_MINIMAL}:5
	>=kde-frameworks/kactivities-${PVCUT}:5
	>=kde-frameworks/kconfig-${PVCUT}:5
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.54
"
