# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
USE_RUBY="ruby25"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5 python-single-r1 ruby-single

DESCRIPTION="Kross interpreter plugins for programming languages"
KEYWORDS=""
IUSE="+python ruby"

REQUIRED_USE="|| ( python ruby ) python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	>=kde-frameworks/kross-${FRAMEWORKS_MINIMAL}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	python? ( ${PYTHON_DEPS} )
	ruby? ( ${RUBY_DEPS} )
"
RDEPEND="${DEPEND}"

pkg_setup() {
	use python && python-single-r1_pkg_setup
	kde5_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_python=$(usex python)
		-DBUILD_ruby=$(usex ruby)
	)

	kde5_src_configure
}
