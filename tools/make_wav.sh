#!/bin/sh
# BASIC listing -> tape recording for the Sharp PC-1360, with a read-back check.
# Uses the Sharp Pocket-Tools (bas2img, bin2wav, wav2bin; sources in this folder).
# Usage: tools/make_wav.sh Basic/listing.txt wav/out.wav NAME     (NAME: up to 7 characters)
set -e
SRC="$1"; OUT="$2"; NAME="$3"
[ -n "$NAME" ] || { echo "usage: $0 listing.txt out.wav NAME"; exit 1; }
D=$(dirname "$0"); B="$D/bin"
mkdir -p "$B"
for t in bas2img bin2wav wav2bin; do
  [ -x "$B/$t" ] || gcc -O2 -o "$B/$t" "$D/$t.c" -lm
done
T=$(mktemp -d)
"$B/bas2img" -q -p 1360 "$SRC" "$T/p.img"
"$B/bin2wav" -q -p 1360 --name="$NAME" "$T/p.img" "$OUT"
"$B/wav2bin" -q -t img -p 1360 "$OUT" "$T/back.img"
cmp "$T/p.img" "$T/back.img" && echo "read-back check OK: $OUT ($(wc -c < "$T/p.img") bytes of program)"
rm -rf "$T"
