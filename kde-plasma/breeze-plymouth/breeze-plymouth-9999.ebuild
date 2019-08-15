# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_KDEINSTALLDIRS="false"
KDE_AUTODEPS="false"
FRAMEWORKS_MINIMAL=5.60.0
PVCUT=$(ver_cut 1-3)
inherit kde5

DESCRIPTION="Breeze theme for Plymouth"
LICENSE="GPL-2+ GPL-3+"
KEYWORDS=""
IUSE=""

BDEPEND=">=kde-frameworks/extra-cmake-modules-${FRAMEWORKS_MINIMAL}:5"
DEPEND="sys-boot/plymouth"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DDISTRO_NAME="Gentoo Linux"
		-DDISTRO_VERSION=
	)

	kde5_src_configure
}
