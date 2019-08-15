# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Job-based library to send email through an SMTP server"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kcoreaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	dev-libs/cyrus-sasl
"
RDEPEND="${DEPEND}"

RESTRICT+=" test" # bug 642410
