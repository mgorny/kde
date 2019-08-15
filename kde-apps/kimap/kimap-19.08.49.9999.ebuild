# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Library for interacting with IMAP servers"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	>=kde-frameworks/kcodecs-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/kmime-${PVCUT}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	dev-libs/cyrus-sasl
"
# TODO: Convince upstream not to install stuff with tests
DEPEND="${COMMON_DEPEND}
	test? ( >=dev-qt/qtnetwork-${QT_MINIMAL}:5 )
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepim-l10n
"

src_test() {
	# tests cannot be run in parallel #605586
	local myctestargs=(
		-j1
	)
	kde5_src_test
}
