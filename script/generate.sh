#!/bin/sh

path=$(realpath "$(dirname $0)/..")

(cd $path && dart run tool/generator.dart data/usb.ids -o lib/src/usb_id.g.dart && dartfmt -w lib/src/usb_id.g.dart)
