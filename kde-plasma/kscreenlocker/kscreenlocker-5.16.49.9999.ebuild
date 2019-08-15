# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
VIRTUALX_REQUIRED="test"
FRAMEWORKS_MINIMAL=5.60.0
PVCUT=$(ver_cut 1-3)
QT_MINIMAL=5.12.3
inherit kde5 pam

DESCRIPTION="Library and components for secure lock screen architecture"
KEYWORDS=""
IUSE="consolekit +pam seccomp"

REQUIRED_USE="seccomp? ( pam )"

RDEPEND="
	>=kde-frameworks/kcmutils-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdeclarative-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kglobalaccel-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kidletime-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifications-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kpackage-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwayland-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/solid-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5[widgets]
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtx11extras-${QT_MINIMAL}:5
	dev-libs/wayland
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libxcb
	x11-libs/xcb-util-keysyms
	consolekit? ( sys-auth/consolekit )
	pam? ( virtual/pam )
	seccomp? ( sys-libs/libseccomp )
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
"
PDEPEND="
	>=kde-plasma/kde-cli-tools-${PVCUT}:5
"

RESTRICT+=" test"

src_prepare() {
	kde5_src_prepare

	if ! use test; then
		sed -e "/add_subdirectory(autotests)/ s/^/#/" \
			-i greeter/CMakeLists.txt || die
	fi
}

src_test() {
	# requires running environment
	local myctestargs=(
		-E x11LockerTest
	)
	kde5_src_test
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package consolekit loginctl)
		-DPAM_REQUIRED=$(usex pam)
		$(cmake-utils_use_find_package pam PAM)
		$(cmake-utils_use_find_package seccomp Seccomp)
	)
	kde5_src_configure
}

src_install() {
	kde5_src_install

	use pam && newpamd "${FILESDIR}/kde.pam" kde
	use pam && newpamd "${FILESDIR}/kde-np.pam" kde-np

	if ! use pam; then
		chown root "${ED}"/usr/$(get_libdir)/libexec/kcheckpass || die
		chmod +s "${ED}"/usr/$(get_libdir)/libexec/kcheckpass || die
	fi
}
