# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde4-base

DESCRIPTION="KDE library for playing & ripping CDs"
KEYWORDS=""
IUSE="alsa debug"

DEPEND="
	media-libs/phonon[qt4]
	alsa? ( media-libs/alsa-lib )
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep phonon-kde)
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package alsa Alsa)
	)
	kde4-base_src_configure
}
