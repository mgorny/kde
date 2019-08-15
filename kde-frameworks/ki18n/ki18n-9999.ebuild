# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )
PVCUT=$(ver_cut 1-2)
QT_MINIMAL=5.12.3
inherit kde5 python-single-r1

DESCRIPTION="Framework based on Gettext for internationalizing user interface text"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:5
	sys-devel/gettext
	virtual/libintl
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qtconcurrent-${QT_MINIMAL}:5 )
"

PATCHES=( "${FILESDIR}/${PN}-5.57.0-python.patch" )

pkg_setup() {
	kde5_pkg_setup
	python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DPYTHON_EXECUTABLE="${PYTHON}"
	)
	kde5_src_configure
}
