# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework for providing different actions given a string query"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kconfig-${PVCUT}:5
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=kde-frameworks/ki18n-${PVCUT}:5
	>=kde-frameworks/kio-${PVCUT}:5
	>=kde-frameworks/kservice-${PVCUT}:5
	>=kde-frameworks/plasma-${PVCUT}:5
	>=kde-frameworks/solid-${PVCUT}:5
	>=kde-frameworks/threadweaver-${PVCUT}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}"

src_test() {
	# requires virtual dbus #630672
	local myctestargs=(
		-E "(dbusrunnertest)"
	)
	kde5_src_test
}
