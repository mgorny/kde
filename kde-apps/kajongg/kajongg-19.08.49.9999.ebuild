# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_AUTODEPS="false"
KDE_HANDBOOK="forceoptional"
PYTHON_COMPAT=( python3_{5,6,7} )
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit python-single-r1 kde5

DESCRIPTION="Classical Mah Jongg for four players"
HOMEPAGE="https://kde.org/applications/games/kajongg/"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	>=kde-frameworks/extra-cmake-modules-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/libkdegames-${PVCUT}:5
	>=dev-qt/qtcore-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	dev-db/sqlite:3
	dev-python/PyQt5[gui,svg,widgets,${PYTHON_USEDEP}]
	>=dev-python/twisted-16.6.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	>=kde-apps/libkmahjongg-${PVCUT}:5
"

pkg_setup() {
	python-single-r1_pkg_setup
	kde5_pkg_setup
}

src_prepare() {
	python_fix_shebang src
	kde5_src_prepare
	sed -i -e "/KDE_ADD_PYTHON_EXECUTABLE/s/^/#DONT/" CMakeLists.txt || die
}

src_install() {
	kde5_src_install
	dosym ../share/kajongg/kajongg.py /usr/bin/kajongg
	dosym ../share/kajongg/kajonggserver.py /usr/bin/kajonggserver
	fperms a+x /usr/share/kajongg/kajongg{,server}.py
}
