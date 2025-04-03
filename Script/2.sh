#!/bin/bash






keyvalue() {

    Brand="Toyota"
    Model="Corolla"
    Year="-2004"
    Chip="93C56"


    if [ $# -lt 2 ]; then
        echo "Usage: keyvalue <file.bin> <offset1> [offset2] [offset3] ..."
        return 1
    fi

    local FILE=$1
    shift

    local FILESIZE
    FILESIZE=$(stat -c %s "$FILE" 2>/dev/null)

#    if [ "$FILESIZE" -eq 256 ]; then
#        echo "${Brand}"
#        echo "✅ File size matches: 256 bytes."
#    else
#        echo "❌ Error: File size is $FILESIZE bytes, expected 256 bytes."
#        return 1
#    fi

    for OFFSET in "$@"; do
        if [ "$OFFSET" -ge "$FILESIZE" ]; then
            echo "Offset $OFFSET is out of range."
            continue
        fi
        local BYTE
        BYTE=$(dd if="$FILE" bs=1 skip="$OFFSET" count=1 2>/dev/null | xxd -p)
        echo -n "$BYTE "
    done
    echo ""
}

echo -n "Key 1  : ID : "
keyvalue 1.bin 128 129 0 1 | tr '[:lower:]' '[:upper:]'
echo -n "Key 2  : ID : "
keyvalue 1.bin 136 137 8 9 | tr '[:lower:]' '[:upper:]'
echo -n "Key 3  : ID : "
keyvalue 1.bin 148 149 20 21 | tr '[:lower:]' '[:upper:]'