# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
PYTHON_COMPAT=( python3_{5,6,7} )
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit python-single-r1 kde5

DESCRIPTION="KDE Applications 5 translation tool"
HOMEPAGE="https://kde.org/applications/development/lokalize
https://l10n.kde.org/tools/"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemviews-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifications-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kross-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/sonnet-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtscript-${QT_MINIMAL}:5
	>=dev-qt/qtsql-${QT_MINIMAL}:5[sqlite]
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
	>=app-text/hunspell-1.2.8:=
"
RDEPEND="${DEPEND}
	dev-python/translate-toolkit[${PYTHON_USEDEP}]
"

pkg_setup() {
	python-single-r1_pkg_setup
	kde5_pkg_setup
}

src_install() {
	kde5_src_install
	python_fix_shebang "${ED}/usr/share/${PN}"
}

pkg_postinst() {
	kde5_pkg_postinst

	has_version dev-vcs/subversion || \
		elog "To be able to autofetch KDE translations in new project wizard, install dev-vcs/subversion."
}
