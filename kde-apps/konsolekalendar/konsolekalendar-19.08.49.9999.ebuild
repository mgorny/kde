# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KMNAME="akonadi-calendar-tools"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
inherit kde5

DESCRIPTION="Command line interface to KDE calendars"
HOMEPAGE+=" https://userbase.kde.org/KonsoleKalendar"

LICENSE="GPL-2+ handbook? ( FDL-1.2+ )"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/akonadi-${PVCUT}:5
	>=kde-apps/akonadi-calendar-${PVCUT}:5
	>=kde-apps/calendarsupport-${PVCUT}:5
	>=kde-apps/kcalcore-${PVCUT}:5
	>=kde-apps/kcalutils-${PVCUT}:5
"
RDEPEND="${DEPEND}
	!kde-apps/kdepim-l10n
"

src_prepare() {
	kde5_src_prepare

	# delete colliding calendarjanitor translations
	if [[ ${KDE_BUILD_TYPE} = release ]]; then
		rm -f po/*/calendarjanitor.po || die
	fi

	cmake_comment_add_subdirectory calendarjanitor
}
