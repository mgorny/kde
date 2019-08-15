# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_QTHELP="false"
KDE_TEST="false"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework providing KDE integration of QtWebKit"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="designer"

RDEPEND="
	>=kde-frameworks/kconfig-${PVCUT}:5
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=kde-frameworks/kio-${PVCUT}:5
	>=kde-frameworks/kjobwidgets-${PVCUT}:5
	>=kde-frameworks/kparts-${PVCUT}:5
	>=kde-frameworks/kservice-${PVCUT}:5
	>=kde-frameworks/kwallet-${PVCUT}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtwebkit-5.212.0_pre20180120:5
	designer? ( >=kde-frameworks/kdesignerplugin-${PVCUT}:5 )
"
DEPEND="${RDEPEND}
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_DESIGNERPLUGIN=$(usex designer)
	)
	kde5_src_configure
}
