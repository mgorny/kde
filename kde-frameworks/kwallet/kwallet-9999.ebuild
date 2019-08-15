# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework providing desktop-wide storage for passwords"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="gpg +man"

BDEPEND="
	man? ( >=kde-frameworks/kdoctools-${PVCUT}:5 )
"
DEPEND="
	>=kde-frameworks/kconfig-${PVCUT}:5
	>=kde-frameworks/kconfigwidgets-${PVCUT}:5
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=kde-frameworks/kdbusaddons-${PVCUT}:5
	>=kde-frameworks/ki18n-${PVCUT}:5
	>=kde-frameworks/kiconthemes-${PVCUT}:5
	>=kde-frameworks/knotifications-${PVCUT}:5
	>=kde-frameworks/kservice-${PVCUT}:5
	>=kde-frameworks/kwidgetsaddons-${PVCUT}:5
	>=kde-frameworks/kwindowsystem-${PVCUT}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	dev-libs/libgcrypt:0=
	gpg? ( >=app-crypt/gpgme-1.7.1[cxx,qt5] )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package gpg Gpgmepp)
		$(cmake-utils_use_find_package man KF5DocTools)
	)

	kde5_src_configure
}

pkg_postinst() {
	if ! has_version "kde-plasma/kwallet-pam" || ! has_version "kde-apps/kwalletmanager:5" ; then
		elog
		elog "Install kde-plasma/kwallet-pam for auto-unlocking after account login."
		elog "Install kde-apps/kwalletmanager:5 to manage your kwallet."
		elog
	fi
	if has_version "kde-apps/kwalletd"; then
		elog "Starting with 5.34.0-r1, ${PN} is able to serve applications"
		elog "that still require old kwalletd4. After migration has finished,"
		elog "kde-apps/kwalletd can be removed."
	fi
	elog "For more information, read https://wiki.gentoo.org/wiki/KDE#KWallet"
}
