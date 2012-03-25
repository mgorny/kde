#!/bin/bash

# Run this script via cronjob to update your overlay mirror

OVERLAY_MIRROR_DIR=/var/gentoo/overlays

# OVERLAY_MIRROR_DIR must contain:
#  * a folder $overlay/ for each overlay you intent to mirror.
#  * a folder cache/ to store the cache of all overlays.
#    (so it is not mixed with the cache of your system portage-trees)
# OVERLAY_MIRROR_DIR/$overlay/ must contain:
#  * a file etc/make.conf with following contents:
#    PORTDIR=/your/portage/directory
#    PORTDIR_OVERLAY=/path/to/your/mirror/dir/$overlay/repo
#    FEATURES="${FEATURES} userpriv userfetch usersandbox usersync metadata-transfer"
#  * a directory repo/ containing the checked out overlay repository
# For speed reasons it is advisable to have a file etc/portage/modules containing:
#    portdbapi.auxdbmodule = portage.cache.sqlite.database

die() {
	echo "USAGE: $0 <overlay>" 1>&2
	echo "ERROR: $@" 1>&2
	exit 1
}

[[ "$1" ]] || die 'overlay'
overlay="$1" ; shift

overlay_name="$(< $OVERLAY_MIRROR_DIR/$overlay/repo/profiles/repo_name)"
[[ "$overlay_name" ]] || die 'overlay_name'

if [ -e "$OVERLAY_MIRROR_DIR/$overlay/repo/.svn" ] ; then
	type=svn
elif [ -e "$OVERLAY_MIRROR_DIR/$overlay/repo/.git" ] ; then
	type=git
else
	die "Unable to determine overlay type for $overlay"
fi

cd $OVERLAY_MIRROR_DIR/$overlay/repo || cd "failed to cd to $OVERLAY_MIRROR_DIR/$overlay/repo"

echo 'Updating overlay ...'
case "$type" in
	svn)
		[ -e metadata/layout.conf ] && svn revert metadata/layout.conf
		svn cleanup || die 'svn cleanup failed'
		svn update --force --config-option=config:miscellany:use-commit-times=yes || die 'svn update failed'
		;;
	git)
		[ -e metadata/layout.conf ] && git checkout metadata/layout.conf
		git pull || die 'git update failed'
		/usr/local/bin/git-set-file-times || die 'setting file times failed'
		;;
	*)
		die "Unsupported overlay type '$type' for $overlay"
esac

export PORTAGE_CONFIGROOT=$OVERLAY_MIRROR_DIR/$overlay PORTAGE_DEPCACHEDIR=$OVERLAY_MIRROR_DIR/cache

echo 'Enforcing full manifests ...'
#sed -e 's/^thin-manifests.*/thin-manifests = false/' -i metadata/layout.conf || die 'patching layout.conf failed'

echo 'Generating manifests ...'
#repoman manifest || die 'generating manifests failed'

echo 'Generating metadata caches ...'
egencache  --config-root=$PORTAGE_CONFIGROOT --cache-dir=$PORTAGE_DEPCACHEDIR --repo=$overlay_name --update
