# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
inherit kde5

DESCRIPTION="KWallet extension for signond"
HOMEPAGE="https://01.org/gsso/"
KEYWORDS=""
LICENSE="GPL-2+"

DEPEND="
	>=kde-frameworks/kwallet-${FRAMEWORKS_MINIMAL}:5
	net-libs/signond
"
RDEPEND="${DEPEND}"
