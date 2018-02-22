#!/usr/bin/env bash

set -euo pipefail

die() {
	echo "$1" >&2
	exit 1
}

clean_up() {
    rm -f *.tex *.idh *.html
    rm -f *.ibc output
}

clean_up

idris --check Foobar.idr --highlight || die "* could not compile tests *"

echo "compiled OK, running tests..."
../idrishl Foobar.idh || die "* test failed *"
cat Foobar.tex Foobar.html > output

# use a default parameter if $1 is not set
if [ "${1-}" = "accept" ]; then
	echo '### marking current output as expected ###'
	cat output > expected
	clean_up
	exit 0
else
	if diff output expected; then
		echo "### everything PASS ###"
		clean_up
		exit 0
	else
		echo "### something FAIL ###"
		clean_up
		exit 1
	fi
fi
