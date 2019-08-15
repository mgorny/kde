# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
PLASMA_MINIMAL=5.15.5
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Manage print jobs and printers in Plasma"
KEYWORDS=""
IUSE="+gtk"

DEPEND="
	>=kde-frameworks/kcmutils-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifications-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/plasma-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	net-print/cups
"
RDEPEND="${DEPEND}
	>=kde-plasma/kde-cli-tools-${PLASMA_MINIMAL}:5
	gtk? ( app-admin/system-config-printer )
"

pkg_postinst(){
	kde5_pkg_postinst

	if [[ -z "${REPLACING_VERSIONS}" ]] && ! use gtk ; then
		ewarn "By switching off \"gtk\" USE flag, you have chosen to do without"
		ewarn "an important, though optional, runtime dependency:"
		ewarn
		ewarn "app-admin/system-config-printer"
		ewarn
		ewarn "${PN} will work nevertheless, but is going to be less comfortable"
		ewarn "and will show the following error status during runtime:"
		ewarn
		ewarn "\"Failed to group devices: 'The name org.fedoraproject.Config.Printing"
		ewarn "was not provided by any .service files'\""
	fi
}
