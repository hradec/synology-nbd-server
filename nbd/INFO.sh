#!/bin/bash
# Copyright (c) 2000-2016 Synology Inc. All rights reserved.

source /pkgscripts/include/pkg_util.sh

package="nbd-3.20"
version="3.20.0000"
displayname="nbd"
maintainer="rhradec"
arch="$(pkg_get_unified_platform)"
description="nbd server"
[ "$(caller)" != "0 NULL" ] && return 0
pkg_dump_info
