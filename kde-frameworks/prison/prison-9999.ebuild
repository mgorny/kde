# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="QRCode and data matrix barcode library"
HOMEPAGE="https://cgit.kde.org/prison.git"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="qml"

DEPEND="
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	media-gfx/qrencode:=
	media-libs/libdmtx
	qml? ( >=dev-qt/qtdeclarative-${QT_MINIMAL}:5 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package qml Qt5Quick)
	)

	kde5_src_configure
}
