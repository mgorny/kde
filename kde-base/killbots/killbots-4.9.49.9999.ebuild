# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Kill the bots or they kill you!"
KEYWORDS=""
IUSE="debug"

# Tests hang, last checked in 4.3.3
RESTRICT="test"
