#!/bin/sh
# Build the directory that gets bind-mounted over LG's Home: the launcher page plus an appinfo.json derived
# from this TV's own stock Home (nothing of LG's is shipped in the repo). Safe to re-run while mounted.
L=/media/developer/cleanyourtv
S=$L/home-overlay
mkdir -p $S
cp $L/app/* $S/
# dahood fork: our launcher (app/dahood.html) is the page Home opens, unless config.json says "launcher": "classic"
# (upstream's page). Copied over index.html so the stock appinfo keeps working and no app-manager restart is needed.
grep -q '"launcher": *"classic"' $L/config.json 2>/dev/null || cp $L/app/dahood.html $S/index.html
node $L/jtool.js stage "$L/backup/home-appinfo.orig.json" "$S/appinfo.json"
