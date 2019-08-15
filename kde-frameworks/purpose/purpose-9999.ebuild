# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_QTHELP="false"
KDE_TEST="forceoptional"
KDE_APPS_MINIMAL=19.04.3
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Library for providing abstractions to get the developer's purposes fulfilled"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="+kaccounts"

DEPEND="
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=kde-frameworks/ki18n-${PVCUT}:5
	>=kde-frameworks/kio-${PVCUT}:5
	>=kde-frameworks/kirigami-${PVCUT}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	kaccounts? (
		>=kde-apps/kaccounts-integration-${KDE_APPS_MINIMAL}:5
		net-libs/accounts-qt
	)
"
RDEPEND="${DEPEND}"

# requires running environment
RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package kaccounts KAccounts)
	)

	kde5_src_configure
}

pkg_postinst(){
	kde5_pkg_postinst

	if ! has_version "kde-misc/kdeconnect[app]" ; then
		elog "Optional runtime dependency:"
		elog "kde-misc/kdeconnect[app] (send through KDE Connect)"
	fi
}
