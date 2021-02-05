#!/usr/bin/env bash

STATUS=$(vagrant status | awk '/default/ {print $2}')

if [[ "${STATUS}" != "running" ]]; then
  vagrant up
fi
