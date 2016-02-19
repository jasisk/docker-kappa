#!/bin/ash
set -e

if [ "$1" = 'kappa' ]; then
    chown -R kappa:kappa .
    shift
    exec tini -- gosu kappa kappa -c config.json
fi

exec "$@"
