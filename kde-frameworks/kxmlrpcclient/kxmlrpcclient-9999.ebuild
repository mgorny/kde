# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework providing client-side support for the XML-RPC protocol"
LICENSE="BSD-2"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=kde-frameworks/ki18n-${PVCUT}:5
	>=kde-frameworks/kio-${PVCUT}:5
	>=dev-qt/qtxml-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}"
