#!/bin/bash

set -e

cat "$1" | tr -s '\n' > "$2"