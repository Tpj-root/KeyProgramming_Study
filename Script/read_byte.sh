#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <file.bin> <byte_offset>"
    exit 1
fi

FILE=$1
OFFSET=$2

BYTE=$(dd if="$FILE" bs=1 skip="$OFFSET" count=1 2>/dev/null | xxd -p)
echo "Byte at offset $OFFSET: $BYTE"
