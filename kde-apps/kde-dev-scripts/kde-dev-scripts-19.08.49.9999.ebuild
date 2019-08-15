# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="true"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
inherit kde5

DESCRIPTION="KDE Development Scripts"
KEYWORDS=""
IUSE=""

# kdelibs4support - required for kdex.dtd
# kdoctools - to use ECM instead of kdelibs4
DEPEND="
	>=kde-frameworks/kdelibs4support-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kdoctools-${FRAMEWORKS_MINIMAL}:5
"
RDEPEND="
	app-arch/advancecomp
	media-gfx/optipng
	dev-perl/XML-DOM
"

src_prepare() {
	kde5_src_prepare

	# bug 275069
	sed -e 's:colorsvn::' -i CMakeLists.txt || die
}
