# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Go game by KDE"
HOMEPAGE="https://www.kde.org/applications/games/kigo/"
KEYWORDS=""
IUSE="debug"

DEPEND="$(add_kdeapps_dep libkdegames)"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep knewstuff '' 16.04.3)
	games-board/gnugo
"
