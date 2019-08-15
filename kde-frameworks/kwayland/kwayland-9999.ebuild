# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Qt-style client and server library wrapper for Wayland libraries"
HOMEPAGE="https://cgit.kde.org/kwayland.git"

LICENSE="LGPL-2.1"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtconcurrent-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5[egl]
	>=dev-libs/wayland-1.15.0
	media-libs/mesa[egl]
	>=dev-libs/wayland-protocols-1.15
"
RDEPEND="${DEPEND}
	>=dev-qt/qtwayland-${QT_MINIMAL}:5
"

# All failing, I guess we need a virtual wayland server
RESTRICT+=" test"
