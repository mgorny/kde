# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-2)
inherit kde5

DESCRIPTION="Framework to install and load packages of non binary content"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="man"

BDEPEND="
	man? ( >=kde-frameworks/kdoctools-${PVCUT}:5 )
"
DEPEND="
	>=kde-frameworks/karchive-${PVCUT}:5
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=kde-frameworks/ki18n-${PVCUT}:5
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package man KF5DocTools)
	)

	kde5_src_configure
}

src_test() {
	#bug 650214
	local myctestargs=( -E "(plasma-plasmoidpackagetest)" )
	kde5_src_test
}
