# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5 udev

DESCRIPTION="Qt wrapper for Bluez 5 DBus API"
LICENSE="LGPL-2"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DUDEV_RULES_INSTALL_DIR="$(get_udevdir)/rules.d"
	)

	kde5_src_configure
}

src_test() {
	# parallel tests fail, bug 609248; managertest hangs, bug 668196
	local myctestargs=(
		-j1
		-E "(managertest)"
	)

	kde5_src_test
}
