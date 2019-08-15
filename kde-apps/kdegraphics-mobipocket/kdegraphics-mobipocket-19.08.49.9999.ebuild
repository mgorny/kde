# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Library to support mobipocket ebooks"
KEYWORDS=""
IUSE="+thumbnail"

DEPEND="
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	thumbnail? ( >=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_thumbnailers=$(usex thumbnail)
	)

	kde5_src_configure
}
