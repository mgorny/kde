# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Framework providing data models to help with tasks such as sorting and filtering"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="test? ( >=dev-qt/qtwidgets-${QT_MINIMAL}:5 )"
