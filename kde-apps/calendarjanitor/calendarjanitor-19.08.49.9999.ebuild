# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional" # FIXME: Check back for doc in release
KDE_TEST="false"
KMNAME="akonadi-calendar-tools"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Tool to scan calendar data for buggy instances"
LICENSE="GPL-2+ handbook? ( FDL-1.2+ )"
KEYWORDS=""

IUSE=""

DEPEND="
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/akonadi-${PVCUT}:5
	>=kde-apps/akonadi-calendar-${PVCUT}:5
	>=kde-apps/calendarsupport-${PVCUT}:5
	>=kde-apps/kcalcore-${PVCUT}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}
	!kde-apps/kdepim-l10n
"

src_prepare() {
	kde5_src_prepare

	cmake_comment_add_subdirectory doc konsolekalendar
	sed -i -e "/console\.categories/ s/^/#DONT/" CMakeLists.txt || die

	# delete colliding konsolekalendar translations
	if [[ ${KDE_BUILD_TYPE} = release ]]; then
		rm -f po/*/konsolekalendar.po || die
		rm -rf po/*/docs/konsolekalendar || die
	fi
}
