# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="optional"
KDE_TEST="optional"
VIRTUALX_REQUIRED="test"
FRAMEWORKS_MINIMAL=5.60.0
PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Flexible, composited Window Manager for windowing systems on Linux"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE="caps gles2 multimedia"

COMMON_DEPEND="
	>=kde-frameworks/kactivities-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kauth-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcmutils-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdeclarative-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kglobalaccel-${FRAMEWORKS_MINIMAL}:5=
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kidletime-${FRAMEWORKS_MINIMAL}:5=
	>=kde-frameworks/kinit-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knewstuff-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifications-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kpackage-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwayland-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5[X]
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/plasma-${FRAMEWORKS_MINIMAL}:5
	>=kde-plasma/breeze-${PVCUT}:5
	>=kde-plasma/kdecoration-${PVCUT}:5
	>=kde-plasma/kscreenlocker-${PVCUT}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5=[gles2=]
	>=dev-qt/qtscript-${QT_MINIMAL}:5
	>=dev-qt/qtsensors-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtx11extras-${QT_MINIMAL}:5
	>=dev-libs/libinput-1.9
	>=dev-libs/wayland-1.2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libepoxy
	media-libs/mesa[egl,gbm,gles2?,wayland]
	virtual/libudev:=
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libdrm
	>=x11-libs/libxcb-1.10
	>=x11-libs/libxkbcommon-0.7.0
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-wm
	caps? ( sys-libs/libcap )
"
RDEPEND="${COMMON_DEPEND}
	>=kde-frameworks/kirigami-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtquickcontrols-${QT_MINIMAL}:5
	>=dev-qt/qtquickcontrols2-${QT_MINIMAL}:5
	>=dev-qt/qtvirtualkeyboard-${QT_MINIMAL}:5
	multimedia? ( >=dev-qt/qtmultimedia-${QT_MINIMAL}:5[gstreamer,qml] )
"
DEPEND="${COMMON_DEPEND}
	>=dev-qt/designer-${QT_MINIMAL}:5
	>=dev-qt/qtconcurrent-${QT_MINIMAL}:5
	x11-base/xorg-proto
"
PDEPEND="
	>=kde-plasma/kde-cli-tools-${PVCUT}:5
"

RESTRICT+=" test"

src_prepare() {
	kde5_src_prepare
	use multimedia || eapply "${FILESDIR}/${PN}-5.16.80-gstreamer-optional.patch"

	# Access violations, bug #640432
	sed -e "s/^ecm_find_qmlmodule.*QtMultimedia/#&/" \
		-i CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package caps Libcap)
	)

	kde5_src_configure
}
