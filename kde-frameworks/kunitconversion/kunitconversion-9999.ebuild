# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework for converting units"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/ki18n-${PVCUT}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}"

src_test() {
	# bug 623938 - needs internet connection
	local myctestargs=(
		-E "(convertertest)"
	)

	kde5_src_test
}
