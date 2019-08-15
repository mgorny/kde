# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_DESIGNERPLUGIN="true"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="A textedit with PIM-specific features"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	>=kde-frameworks/kcodecs-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kemoticons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/sonnet-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/syntax-highlighting-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtspeech-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	dev-libs/grantlee:5
"
DEPEND="${COMMON_DEPEND}
	test? ( >=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5 )
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepim-l10n
"

RESTRICT+=" test"
