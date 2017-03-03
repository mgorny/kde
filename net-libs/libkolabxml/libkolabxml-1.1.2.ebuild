# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Kolab XML format schema definitions library"
HOMEPAGE="http://www.kolab.org"
SRC_URI="http://mirror.kolabsys.com/pub/releases/${P}.tar.gz"

LICENSE="Apache-2.0 ZLIB LGPL-3+ public-domain"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
IUSE="csharp java python php qt5 test tools"

COMMON_DEPEND="
	>=dev-libs/boost-1.42.0:=[threads]
	dev-libs/xerces-c
	net-misc/curl
"
# 	csharp? ( >=dev-lang/swig-2.0.7 dev-lang/mono )
# 	java? ( >=dev-lang/swig-2.0.7 >=virtual/jdk-1.7 )
# 	php? ( >=dev-lang/swig-2.0.7 dev-lang/php )
# 	python? ( >=dev-lang/swig-2.0.7 dev-lang/python )
DEPEND="${COMMON_DEPEND}
	dev-cpp/xsd
	test? (
		qt5? (
			dev-qt/qtcore:5
			dev-qt/qttest:5
			kde-frameworks/extra-cmake-modules
		)
		!qt5? ( dev-qt/qttest:4 )
	)
"
RDEPEND="${COMMON_DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-1.1.1-GNUInstallDirs.patch"
	"${FILESDIR}/${PN}-1.1.1-install-kolabformatchecker.patch"
)

src_prepare() {
	rm -r src/{csharp,java,php,python} || die "Failed to remove bindings"
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCSHARP_BINDINGS=OFF
		-DJAVA_BINDINGS=OFF
		-DPHP_BINDINGS=OFF
		-DPYTHON_BINDINGS=OFF
		-DQT5_BUILD=$(usex qt5)
		-DBUILD_TESTS=$(usex test)
		-DBUILD_UTILS=$(usex tools)
	)
	cmake-utils_src_configure
}
