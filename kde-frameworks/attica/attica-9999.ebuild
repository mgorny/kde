# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework providing access to Open Collaboration Services"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
"
DEPEND="${RDEPEND}"

src_test() {
	# requires network access, bug #661230
	local myctestargs=(
		-E "(providertest)"
	)

	kde5_src_test
}
