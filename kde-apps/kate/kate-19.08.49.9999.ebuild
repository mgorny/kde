# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="optional"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Kate is an advanced text editor"
HOMEPAGE="https://kde.org/applications/utilities/kate https://kate-editor.org/"
KEYWORDS=""
IUSE="+addons"

DEPEND="
	>=kde-frameworks/kactivities-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcodecs-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kguiaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemmodels-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemviews-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kjobwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktexteditor-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	addons? (
		>=kde-frameworks/kbookmarks-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/knewstuff-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/kwallet-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/plasma-${FRAMEWORKS_MINIMAL}:5
		>=kde-frameworks/threadweaver-${FRAMEWORKS_MINIMAL}:5
		>=dev-qt/qtsql-${QT_MINIMAL}:5
	)
"
RDEPEND="${DEPEND}
	!kde-misc/ktexteditorpreviewplugin
"

src_prepare() {
	kde5_src_prepare

	# delete colliding kwrite translations
	if [[ ${KDE_BUILD_TYPE} = release ]]; then
		find po -type f -name "*po" -and -name "kwrite*" -delete || die
		rm -rf po/*/docs/kwrite || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_addons=$(usex addons)
		-DBUILD_kwrite=FALSE
	)

	kde5_src_configure
}

src_test() {
	# tests hang
	local myctestargs=(
		-E "(session_manager_test|sessions_action_test)"
	)

	kde5_src_test
}

pkg_postinst() {
	kde5_pkg_postinst

	if [[ -z "${REPLACING_VERSIONS}" ]] && use addons; then
		elog "The functionality of ktexteditorpreview plugin can be extended with:"
		elog "  kde-misc/kmarkdownwebview"
		elog "  media-gfx/kgraphviewer"
	fi
}
