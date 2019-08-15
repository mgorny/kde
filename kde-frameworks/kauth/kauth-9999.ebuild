# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework to let applications perform actions as a privileged user"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="nls +policykit"

BDEPEND="
	nls? ( >=dev-qt/linguist-tools-${QT_MINIMAL}:5 )
"
DEPEND="
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	policykit? ( sys-auth/polkit-qt[qt5(+)] )
"
RDEPEND="${DEPEND}"
PDEPEND="policykit? ( kde-plasma/polkit-kde-agent )"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package policykit PolkitQt5-1)
	)

	kde5_src_configure
}

src_test() {
	# KAuthHelperTest test fails, bug 654842
	local myctestargs=(
		-E "(KAuthHelperTest)"
	)

	kde5_src_test
}
