#!/bin/bash
# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /opt/bitnami/scripts/libos.sh
. /opt/bitnami/scripts/libmariadb.sh

# Load MariaDB environment variables
. /opt/bitnami/scripts/mariadb-env.sh

# Ensure MariaDB unix socket file does not exist
rm -rf "${DB_SOCKET_FILE}.lock"

flags=("--defaults-file=${DB_CONF_DIR}/my.cnf" "--basedir=${DB_BASE_DIR}" "--datadir=${DB_DATA_DIR}" "--socket=${DB_SOCKET_FILE}")
[[ -z "${DB_PID_FILE:-}" ]] || flags+=("--pid-file=${DB_PID_FILE}")

# Add flags specified via the 'DB_EXTRA_FLAGS' environment variable
read -r -a db_extra_flags <<< "$(mariadb_extra_flags)"
[[ "${#db_extra_flags[@]}" -gt 0 ]] && flags+=("${db_extra_flags[@]}")

# Add flags passed to this script
flags+=("$@")

# Fix for MDEV-16183 - mariadbd-safe already does this, but we are using mariadbd
LD_PRELOAD="$(find_jemalloc_lib)${LD_PRELOAD:+ "$LD_PRELOAD"}"
export LD_PRELOAD

info "** Starting MariaDB **"
if am_i_root; then
    exec_as_user "$DB_DAEMON_USER" "${DB_SBIN_DIR}/mariadbd" "${flags[@]}"
else
    exec "${DB_SBIN_DIR}/mariadbd" "${flags[@]}"
fi
