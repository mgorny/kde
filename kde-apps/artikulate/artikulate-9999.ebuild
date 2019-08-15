# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="optional"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Language learning application that helps improving pronunciation skills"
HOMEPAGE="https://edu.kde.org/applications/language/artikulate"
KEYWORDS=""
IUSE="+gstreamer qtmedia"

REQUIRED_USE="|| ( gstreamer qtmedia )"

DEPEND="
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knewstuff-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtsql-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	>=dev-qt/qtxmlpatterns-${QT_MINIMAL}:5
	gstreamer? ( >=media-libs/qt-gstreamer-1.2.0[qt5(+)] )
	qtmedia? ( >=dev-qt/qtmultimedia-${QT_MINIMAL}:5 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_GSTREAMER_PLUGIN=$(usex gstreamer)
		-DBUILD_QTMULTIMEDIA_PLUGIN=$(usex qtmedia)
	)

	kde5_src_configure
}
