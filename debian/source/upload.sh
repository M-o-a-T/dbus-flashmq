#!/bin/sh
set -ex

git checkout debian

B="$(git describe --tags --match "v*" main | sed -e s/-.*//)"
test -n "$B"


D="$(git describe --tags --exact-match debian || echo '')"
if test -z "$D" ; then
	git-debpush -u AFD79782F3BAEC020B28A19F72CF8E5E25B4C293 --upstream "$B" --remote salsa --quilt=baredebian
	D="$(git describe --tags --exact-match debian)"
fi
test -n "$D"
git push salsa $B $D
