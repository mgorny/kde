# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_EXAMPLES="true"
KDE_QTHELP="false"
KDE_TEST="true"
KMNAME="${PN}2"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Lightweight user interface framework for mobile and convergent applications"
HOMEPAGE="https://techbase.kde.org/Kirigami"
EGIT_REPO_URI="${EGIT_REPO_URI/${PN}2/${PN}}"

LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

BDEPEND="
	>=dev-qt/linguist-tools-${QT_MINIMAL}:5
"
DEPEND="
	>=dev-qt/qtdbus-${QT_MINIMAL}:5
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	>=dev-qt/qtgraphicaleffects-${QT_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtquickcontrols2-${QT_MINIMAL}:5
	>=dev-qt/qtsvg-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}"

# requires package to already be installed
RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex examples)
	)

	kde5_src_configure
}
