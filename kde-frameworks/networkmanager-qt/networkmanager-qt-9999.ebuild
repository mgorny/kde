# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="NetworkManager bindings for Qt"
LICENSE="LGPL-2"
KEYWORDS=""
IUSE="teamd"

BDEPEND="
	virtual/pkgconfig
"
DEPEND="
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=net-misc/networkmanager-1.4.0-r1[teamd=]
"
RDEPEND="${DEPEND}
	!net-libs/libnm-qt:5
	|| (
		>=net-misc/networkmanager-1.4.0-r1[consolekit]
		>=net-misc/networkmanager-1.4.0-r1[elogind]
		>=net-misc/networkmanager-1.4.0-r1[systemd]
	)
"

src_test() {
	# bug: 625276
	local myctestargs=( -E "(managertest|settingstest|activeconnectiontest)" )

	kde5_src_test
}
