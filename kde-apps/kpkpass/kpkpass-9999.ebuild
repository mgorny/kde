# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="true"
KFMIN=5.85.0
QTMIN=5.15.2
VIRTUALX_REQUIRED="test"
inherit ecm kde.org

DESCRIPTION="Library to deal with Apple Wallet pass files"
HOMEPAGE="https://apps.kde.org/kontact/"

LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtgui-${QTMIN}:5
	>=kde-frameworks/karchive-${KFMIN}:5
"
RDEPEND="${DEPEND}"
