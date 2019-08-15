# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_DESIGNERPLUGIN="true"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework for managing menu and toolbar actions in an abstract way"
KEYWORDS=""
LICENSE="LGPL-2+"
IUSE="attica"

# slot op: includes QtCore/private/qlocale_p.h
DEPEND="
	>=kde-frameworks/kconfig-${PVCUT}:5
	>=kde-frameworks/kconfigwidgets-${PVCUT}:5
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=kde-frameworks/kglobalaccel-${PVCUT}:5
	>=kde-frameworks/ki18n-${PVCUT}:5
	>=kde-frameworks/kiconthemes-${PVCUT}:5
	>=kde-frameworks/kitemviews-${PVCUT}:5
	>=kde-frameworks/ktextwidgets-${PVCUT}:5
	>=kde-frameworks/kwidgetsaddons-${PVCUT}:5
	>=kde-frameworks/kwindowsystem-${PVCUT}:5
	>=dev-qt/qtcore-${QT_MINIMAL}:5=
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5[ssl]
	>=dev-qt/qtprintsupport-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	attica? ( >=kde-frameworks/attica-${PVCUT}:5 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package attica KF5Attica)
	)

	kde5_src_configure
}

src_test() {
	# Files are missing; whatever. Bugs 650290, 668198
	local myctestargs=(
		-E "(ktoolbar_unittest|kxmlgui_unittest)"
	)

	kde5_src_test
}
