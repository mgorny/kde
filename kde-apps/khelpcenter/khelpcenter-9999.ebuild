# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
PLASMA_MINIMAL=5.15.5
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="The KDE Help Center"
HOMEPAGE+=" https://userbase.kde.org/KHelpCenter"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kbookmarks-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcodecs-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdoctools-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/khtml-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kinit-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	dev-libs/grantlee:5
	dev-libs/libxml2
	dev-libs/xapian:=
"
RDEPEND="${DEPEND}
	>=kde-plasma/kde-cli-tools-${PLASMA_MINIMAL}:5
"

src_prepare() {
	kde5_src_prepare
	sed -e "/^install.*kde4\/services/s/^/#DONT/" -i CMakeLists.txt || die
}
