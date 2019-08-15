# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="optional"
KDE_TEST="forceoptional"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Certificate manager and GUI for OpenPGP and CMS cryptography"
HOMEPAGE="https://kde.org/applications/utilities/kleopatra"

LICENSE="GPL-2+ handbook? ( FDL-1.2+ )"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kcmutils-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcodecs-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemmodels-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifications-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/kmime-${PVCUT}:5
	>=kde-apps/libkleo-${PVCUT}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtprintsupport-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=app-crypt/gpgme-1.11.1[cxx,qt5]
	dev-libs/boost:=
	dev-libs/libassuan
	dev-libs/libgpg-error
"
RDEPEND="${DEPEND}
	!kde-apps/kdepim-l10n
	>=app-crypt/gnupg-2.1
	app-crypt/paperkey
"

# tests completely broken, bug #641720
RESTRICT+=" test"
