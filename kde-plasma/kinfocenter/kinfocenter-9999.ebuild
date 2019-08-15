# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MIN_VERSION=3.14.3
KDE_HANDBOOK="forceoptional"
FRAMEWORKS_MINIMAL=5.60.0
PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Utility providing information about the computer hardware"
HOMEPAGE="https://kde.org/applications/system/kinfocenter/"
SRC_URI+=" https://www.gentoo.org/assets/img/logo/gentoo-3d-small.png -> glogo-small.png"
KEYWORDS=""
IUSE="gles2 ieee1394 +opengl +pci wayland"

REQUIRED_USE="wayland? ( || ( gles2 opengl ) )"

COMMON_DEPEND="
	>=kde-frameworks/kcmutils-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdeclarative-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kpackage-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/solid-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	x11-libs/libX11
	ieee1394? ( sys-libs/libraw1394 )
	opengl? (
		>=dev-qt/qtgui-${QT_MINIMAL}:5[gles2=]
		media-libs/mesa[gles2?]
		!gles2? ( media-libs/glu )
	)
	pci? ( sys-apps/pciutils )
	wayland? (
		>=kde-frameworks/kwayland-${FRAMEWORKS_MINIMAL}:5
		media-libs/mesa[egl]
	)
"
DEPEND="${COMMON_DEPEND}
	>=kde-frameworks/plasma-${FRAMEWORKS_MINIMAL}:5
"
RDEPEND="${COMMON_DEPEND}
	>=kde-plasma/kde-cli-tools-${PVCUT}:5
	>=dev-qt/qtquickcontrols2-${QT_MINIMAL}:5
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package ieee1394 RAW1394)
		$(cmake-utils_use_find_package pci PCIUTILS)
		$(cmake-utils_use_find_package wayland EGL)
		$(cmake-utils_use_find_package wayland KF5Wayland)
	)

	if has_version "dev-qt/qtgui[gles2]"; then
		mycmakeargs+=( $(cmake-utils_use_find_package gles2 OpenGLES) )
	else
		mycmakeargs+=( $(cmake-utils_use_find_package opengl OpenGL) )
	fi

	kde5_src_configure
}

src_install() {
	kde5_src_install

	# TODO: Make this fully obsolete by /etc/os-release
	insinto /etc/xdg
	doins "${FILESDIR}"/kcm-about-distrorc

	insinto /usr/share/${PN}
	doins "${DISTDIR}"/glogo-small.png
}

pkg_postinst() {
	kde5_pkg_postinst

	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		has_version "net-fs/nfs-utils" || \
			elog "Installing net-fs/nfs-utils will enable the NFS information module."

		has_version "net-fs/samba" || \
			elog "Installing net-fs/samba will enable the Samba status information module."
	fi
}
