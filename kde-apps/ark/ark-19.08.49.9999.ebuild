# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_TEST="optional"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="KDE Archiving tool"
HOMEPAGE="https://kde.org/applications/utilities/ark
https://utils.kde.org/projects/ark/"
KEYWORDS=""
IUSE="bzip2 lzma zip"

BDEPEND="
	sys-devel/gettext
"
RDEPEND="
	>=kde-frameworks/karchive-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcompletion-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcrash-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdbusaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kiconthemes-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kitemmodels-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kjobwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kparts-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kpty-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kservice-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kxmlgui-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	app-arch/libarchive:=[bzip2?,lzma?,zlib]
	sys-libs/zlib
	zip? ( >=dev-libs/libzip-1.2.0:= )
"
DEPEND="${RDEPEND}
	>=dev-qt/qtconcurrent-${QT_MINIMAL}:5
"

# bug #560548, last checked with 16.04.1
RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package bzip2 BZip2)
		$(cmake-utils_use_find_package lzma LibLZMA)
		$(cmake-utils_use_find_package zip LibZip)
	)

	kde5_src_configure
}

pkg_postinst() {
	kde5_pkg_postinst

	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		if ! has_version app-arch/rar; then
			elog "For creating/extracting rar archives, installing app-arch/rar is required."
			if ! has_version app-arch/unar && ! has_version app-arch/unrar; then
				elog "Alternatively, for only extracting rar archives, install app-arch/unar (free) or app-arch/unrar (non-free)."
			fi
		fi

		has_version app-arch/p7zip || \
			elog "For handling 7-Zip archives, install app-arch/p7zip."

		has_version app-arch/lrzip || \
			elog "For handling lrz archives, install app-arch/lrzip."
	fi
}
