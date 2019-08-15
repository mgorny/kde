# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_TEST="forceoptional"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Email client, supporting POP3 and IMAP mailboxes."
HOMEPAGE="https://kde.org/applications/internet/kmail/"
LICENSE="GPL-2+ handbook? ( FDL-1.2+ )"
KEYWORDS=""
IUSE=""

BDEPEND="
	dev-libs/libxslt
	test? ( >=kde-apps/akonadi-${PVCUT}:5[tools] )
"
COMMON_DEPEND="
	>=kde-frameworks/kbookmarks-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcmutils-${FRAMEWORKS_MINIMAL}:5
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
	>=kde-frameworks/kitemviews-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kjobwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifications-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/knotifyconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwindowsystem-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/sonnet-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/akonadi-${PVCUT}:5
	>=kde-apps/akonadi-contacts-${PVCUT}:5
	>=kde-apps/akonadi-mime-${PVCUT}:5
	>=kde-apps/akonadi-search-${PVCUT}:5
	>=kde-apps/kcalcore-${PVCUT}:5
	>=kde-apps/kcontacts-${PVCUT}:5
	>=kde-apps/kdepim-apps-libs-${PVCUT}:5
	>=kde-apps/kidentitymanagement-${PVCUT}:5
	>=kde-apps/kmailtransport-${PVCUT}:5
	>=kde-apps/kmime-${PVCUT}:5
	>=kde-apps/kontactinterface-${PVCUT}:5
	>=kde-apps/kpimtextedit-${PVCUT}:5
	>=kde-apps/libgravatar-${PVCUT}:5
	>=kde-apps/libkdepim-${PVCUT}:5
	>=kde-apps/libkleo-${PVCUT}:5
	>=kde-apps/libksieve-${PVCUT}:5
	>=kde-apps/libktnef-${PVCUT}:5
	>=kde-apps/mailcommon-${PVCUT}:5
	>=kde-apps/messagelib-${PVCUT}:5
	>=kde-apps/pimcommon-${PVCUT}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtwebengine-${QT_MINIMAL}:5[widgets]
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	>=app-crypt/gpgme-1.11.1[cxx,qt5]
"
DEPEND="${COMMON_DEPEND}
	>=kde-apps/kcalutils-${PVCUT}:5
	>=kde-apps/kldap-${PVCUT}:5
	test? ( >=kde-apps/akonadi-${PVCUT}:5[sqlite] )
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepim-common-libs:4
	!kde-apps/kdepim-l10n
	!kde-apps/ktnef
	>=kde-apps/kdepim-runtime-${PVCUT}:5
	>=kde-apps/kmail-account-wizard-${PVCUT}:5
"

RESTRICT+=" test" # bug 616878

src_prepare() {
	kde5_src_prepare

	if ! use handbook; then
		sed -i ktnef/CMakeLists.txt -e "/add_subdirectory(doc)/ s/^/#DONT/" || die
	fi
}

pkg_postinst() {
	kde5_pkg_postinst

	pkg_is_installed() {
		echo "${1} ($(has_version ${1} || echo "not ")installed)"
	}

	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "KMail supports the following runtime dependencies:"
		elog "  Virus detection:"
		elog "    $(pkg_is_installed app-antivirus/clamav)"
		elog "  Spam filtering:"
		elog "    $(pkg_is_installed mail-filter/bogofilter)"
		elog "    $(pkg_is_installed mail-filter/spamassassin)"
		elog "  Fancy e-mail headers and various useful plugins:"
		elog "    $(pkg_is_installed kde-apps/kdepim-addons:${SLOT})"
		elog "  Crypto config and certificate details GUI:"
		elog "    $(pkg_is_installed kde-apps/kleopatra:${SLOT})"
	fi
}
