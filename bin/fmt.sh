#!/usr/bin/env bash
v fmt -w .
find . -name '*.v' -type f -exec bash -c 'expand -t 4 "{}" | sponge "{}"' \;