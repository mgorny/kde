# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_TEST="forceoptional"
VIRTUALX_REQUIRED="test"
KDE_APPS_MINIMAL=19.04.3
FRAMEWORKS_MINIMAL=5.60.0
PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5 qmake-utils

DESCRIPTION="KDE Plasma workspace"
KEYWORDS=""
IUSE="appstream +calendar geolocation gps qalculate qrcode +semantic-desktop systemd"

REQUIRED_USE="gps? ( geolocation )"

COMMON_DEPEND="
	>=kde-frameworks/kactivities-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kauth-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kbookmarks-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdeclarative-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kded-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdelibs4support-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kglobalaccel-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kguiaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kidletime-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemmodels-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemviews-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kjobwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knewstuff-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifications-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifyconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kpackage-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/krunner-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktexteditor-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwallet-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwayland-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/plasma-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/solid-${FRAMEWORKS_MINIMAL}:5
	>=kde-plasma/kscreenlocker-${PVCUT}:5
	>=kde-plasma/kwin-${PVCUT}:5
	>=kde-plasma/libkscreen-${PVCUT}:5
	>=kde-plasma/libksysguard-${PVCUT}:5
	>=kde-plasma/libkworkspace-${PVCUT}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5[widgets]
	>=dev-qt/qtgui-${QT_MINIMAL}:5[jpeg]
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtsql-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtx11extras-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	media-libs/phonon[qt5(+)]
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/xcb-util
	x11-libs/xcb-util-image
	appstream? ( dev-libs/appstream[qt5] )
	calendar? ( >=kde-frameworks/kholidays-${FRAMEWORKS_MINIMAL}:5 )
	geolocation? ( >=kde-frameworks/networkmanager-qt-${FRAMEWORKS_MINIMAL}:5 )
	gps? ( sci-geosciences/gpsd )
	qalculate? ( sci-libs/libqalculate:= )
	qrcode? ( >=kde-frameworks/prison-${FRAMEWORKS_MINIMAL}:5 )
	semantic-desktop? ( >=kde-frameworks/baloo-${FRAMEWORKS_MINIMAL}:5 )
"
DEPEND="${COMMON_DEPEND}
	>=dev-qt/qtconcurrent-${QT_MINIMAL}:5
	x11-base/xorg-proto
"
RDEPEND="${COMMON_DEPEND}
	>=kde-frameworks/kdesu-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kirigami-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/kio-extras-${KDE_APPS_MINIMAL}:5
	>=kde-plasma/ksysguard-${PVCUT}:5
	>=kde-plasma/milou-${PVCUT}:5
	>=kde-plasma/plasma-integration-${PVCUT}:5
	>=dev-qt/qdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgraphicaleffects-${QT_MINIMAL}:5
	>=dev-qt/qtpaths-${QT_MINIMAL}:5
	>=dev-qt/qtquickcontrols-${QT_MINIMAL}:5[widgets]
	>=dev-qt/qtquickcontrols2-${QT_MINIMAL}:5
	app-text/iso-codes
	x11-apps/xmessage
	x11-apps/xprop
	x11-apps/xrdb
	x11-apps/xsetroot
	systemd? ( sys-apps/dbus[user-session] )
	!systemd? ( sys-apps/dbus )
	!<kde-plasma/plasma-desktop-5.14.80:5
"
PDEPEND="
	>=kde-plasma/kde-cli-tools-${PVCUT}:5
"

PATCHES=(
	# TODO: Restore Gentoo part for FHS installs, bug 688366
	"${FILESDIR}/${PN}-5.14.2-split-libkworkspace.patch"
)

RESTRICT+=" test"

src_prepare() {
	kde5_src_prepare

	cmake_comment_add_subdirectory libkworkspace
	# delete colliding libkworkspace translations
	if [[ ${KDE_BUILD_TYPE} = release ]]; then
		find po -type f -name "*po" -and -name "libkworkspace*" -delete || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_xembed-sni-proxy=OFF
		$(cmake-utils_use_find_package appstream AppStreamQt)
		$(cmake-utils_use_find_package calendar KF5Holidays)
		$(cmake-utils_use_find_package geolocation KF5NetworkManagerQt)
		$(cmake-utils_use_find_package qalculate Qalculate)
		$(cmake-utils_use_find_package qrcode KF5Prison)
		$(cmake-utils_use_find_package semantic-desktop KF5Baloo)
	)

	use gps && mycmakeargs+=( $(cmake-utils_use_find_package gps libgps) )

	kde5_src_configure
}

src_install() {
	kde5_src_install

	# startup and shutdown scripts
	insinto /etc/plasma/startup
	doins "${FILESDIR}/10-agent-startup.sh"

	insinto /etc/plasma/shutdown
	doins "${FILESDIR}/10-agent-shutdown.sh"
}

pkg_postinst () {
	kde5_pkg_postinst

	elog "TODO: /etc/plasma/{startup,shutdown} locations for gpg-agent/ssh-agent"
	elog "do not currently work, see bug #688366."
}
