# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_EXAMPLES="true"
KDE_TEST="forceoptional-recursive"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Plugins for KDE Personal Information Management Suite"
HOMEPAGE="https://kde.org/applications/office/kontact/"

LICENSE="GPL-2+ LGPL-2.1+"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep prison)
	$(add_frameworks_dep syntax-highlighting)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-contacts)
	$(add_kdeapps_dep akonadi-notes)
	$(add_kdeapps_dep calendarsupport)
	$(add_kdeapps_dep eventviews)
	$(add_kdeapps_dep grantleetheme)
	$(add_kdeapps_dep incidenceeditor)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kdepim-apps-libs)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_kdeapps_dep kimap)
	$(add_kdeapps_dep kitinerary)
	$(add_kdeapps_dep kmailtransport)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep kpkpass)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep libkleo)
	$(add_kdeapps_dep libksieve)
	$(add_kdeapps_dep libktnef)
	$(add_kdeapps_dep mailcommon)
	$(add_kdeapps_dep messagelib)
	$(add_kdeapps_dep pimcommon)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
"
DEPEND="${COMMON_DEPEND}
	>=app-crypt/gpgme-1.11.1[cxx,qt5]
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kaddressbook:4
	!kde-apps/kdepim-l10n
	!kde-apps/kmail:4
"

RESTRICT+=" test"

# This package will only install 'common' plugins inside the plugins subdir.
# Top-level plugins are merged in their respective rdeps via USE=addons.
src_prepare() {
	kde5_src_prepare
	local po_filter keep_subdir=( examples plugins po )

	sed -e "/find_package(KF5/ s/ REQUIRED//" \
		-e "/find_package(Qt5 / s/ REQUIRED/ OPTIONAL_COMPONENTS/" \
		-i CMakeLists.txt || die "Failed to make dependencies optional"

	comment_external_subdir() {
		[[ -z ${1} ]] && die "${FUNCNAME}: Usage: <subdir> [\${CATEGORY}/\${PN}]"
		[[ ! -e ${1} ]] && die "${FUNCNAME}: subdir '${1}' does not exist!"
		cmake_comment_add_subdirectory ${1}
		keep_subdir+=( ${1} )
		po_filter+=" $(get_po_list ${1})"
		[[ -z ${2} ]] \
			&& einfo "${1} -> ${CATEGORY}/${1}[addons]" \
			|| einfo "${1} -> ${2}[addons]"
	}

	einfo "The following directories are built by other packages instead:"
	comment_external_subdir akonadi-import-wizard
	comment_external_subdir kaddressbook
	comment_external_subdir kmail
	comment_external_subdir kmailtransport
	comment_external_subdir korganizer
	comment_external_subdir sieveeditor kde-apps/pim-sieve-editor

	pushd "${S}" > /dev/null || die
	local subdir
	for subdir in *; do
		if ! has ${subdir} ${keep_subdir[@]} ; then
			if [[ -d "${subdir}" ]] ; then
				ewarn "Unhandled subdir: ${subdir}"
				# ^ add to keep_subdir or corresponding package
			fi
		fi
	done
	popd > /dev/null || die

	if [[ -d po ]]; then
		local po
		for po in ${po_filter}; do
			rm -f po/*/${po}.po || die "Failed to remove ${po}.po";
		done
	fi
}

src_configure() {
	local mycmakeargs=(
		-DKDEPIMADDONS_BUILD_EXAMPLES=$(usex examples)
	)

	kde5_src_configure
}
