# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_TEST="true"
KMNAME="plasma-workspace"
inherit kde5

DESCRIPTION="Workspace library to interact with the Plasma session manager"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep plasma)
	$(add_frameworks_dep kwindowsystem)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtx11extras)
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
"
RDEPEND="${DEPEND}
	!kde-plasma/libkworkspace:4
	!<kde-plasma/plasma-workspace-5.14.1-r1:5
"

S="${S}/${PN}"

PATCHES=( "${FILESDIR}/${PN}-5.14.2-standalone.patch" )

src_prepare() {
	kde5_src_prepare
	sed -e "/set/s/GENTOO_PV/${PV}/" \
		-e "/set/s/GENTOO_QT_MINIMAL/${QT_MINIMAL}/" \
		-e "/set/s/GENTOO_KF5_MINIMAL/${FRAMEWORKS_MINIMAL}/" \
		-i CMakeLists.txt || die "Failed to prepare CMakeLists.txt"
}
