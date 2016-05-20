# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_SUBPROJ="${PN#kdepim-}"
KDE_TEST="forceoptional"
KMNAME="kdepim-addons"
QT_MINIMAL="5.6.0"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Plugins for KDE Personal Information Management Suite"
HOMEPAGE="https://www.kde.org/applications/office/kontact/"
KEYWORDS=""

IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-notes)
	$(add_kdeapps_dep calendarsupport)
	$(add_kdeapps_dep eventviews)
	$(add_kdeapps_dep grantleetheme)
	$(add_kdeapps_dep incidenceeditor)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kdepim-apps-libs)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep libkleo)
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
	$(add_kdeapps_dep gpgmepp)
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepim:5
	!kde-apps/kdepim-addons:5
"
