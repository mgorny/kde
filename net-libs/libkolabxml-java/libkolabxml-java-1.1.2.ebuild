# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_IN_SOURCE_BUILD="true"
JAVA_PKG_IUSE="source"
JAVA_SRC_DIR="src/java"
inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Kolab XML format schema definitions library"
HOMEPAGE="http://www.kolab.org"
SRC_URI="http://mirror.kolabsys.com/pub/releases/${PN%\-*}-${PV}.tar.gz"

LICENSE="Apache-2.0 ZLIB LGPL-3+ public-domain"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
IUSE=""

COMMON_DEPEND="
	dev-libs/xerces-c
"
DEPEND="${COMMON_DEPEND}
	>=dev-lang/swig-2.0.7
	>=virtual/jdk-1.7
"
RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${P}"

src_configure() {
	local mycmakeargs=(
		-DJAVA_BINDINGS=ON
		-DCSHARP_BINDINGS=OFF
		-DPHP_BINDINGS=OFF
		-DPYTHON_BINDINGS=OFF
		-DQT5_BUILD=$(usex qt5)
		-DBUILD_TESTS=$(usex test)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use java ; then
		java-pkg-simple_src_compile
# 		rm -r ${JAVA_SRC_DIR} || die "Failed to remove source dir"
	fi
}

src_install() {
	java-pkg-simple_src_install
}
