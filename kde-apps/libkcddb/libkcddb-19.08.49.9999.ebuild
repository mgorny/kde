# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_TEST="true"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="KDE library for CDDB"
LICENSE="GPL-2+ handbook? ( FDL-1.2 )"
KEYWORDS=""
IUSE="musicbrainz"

DEPEND="
	>=kde-frameworks/kcodecs-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kconfigwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	musicbrainz? ( media-libs/musicbrainz:5 )
"
RDEPEND="${DEPEND}"

# tests require network access and compare static data with online data
# bug 280996
RESTRICT+=" test"

src_prepare() {
	kde5_src_prepare

	if ! use handbook ; then
		pushd kcmcddb > /dev/null
		cmake_comment_add_subdirectory doc
		popd > /dev/null
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package musicbrainz MusicBrainz5)
	)

	kde5_src_configure
}
