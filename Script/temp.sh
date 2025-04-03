

dd if="1.bin" bs=1 skip="1" count=1 2>/dev/null | xxd -p


 GUI hex editors available for Debian
sudo apt install bless

chnage the setting 
view -> layout -> bless-16-bytes-per-row.layout


every key have three location find the all the location

small to caps convertro




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

    if [ "$FILESIZE" -eq 256 ]; then
        echo "${Brand}"
        echo "✅ File size matches: 256 bytes."
    else
        echo "❌ Error: File size is $FILESIZE bytes, expected 256 bytes."
        return 1
    fi

    for OFFSET in "$@"; do
        if [ "$OFFSET" -ge "$FILESIZE" ]; then
            echo "Offset $OFFSET is out of range."
            continue
        fi
        local BYTE
        BYTE=$(dd if="$FILE" bs=1 skip="$OFFSET" count=1 2>/dev/null | xxd -p)
        echo "$OFFSET: $BYTE"
    done
}



readbin() {
    if [ $# -lt 1 ]; then
        echo "Usage: readbin <file.bin>"
        return 1
    fi

    local FILE=$1

    if [ ! -f "$FILE" ]; then
        echo "❌ Error: File '$FILE' not found."
        return 1
    fi

    local FILESIZE
    FILESIZE=$(stat -c %s "$FILE" 2>/dev/null)

    if [ "$FILESIZE" -ne 256 ]; then
        echo "❌ Error: File size is $FILESIZE bytes, expected 256 bytes."
        return 1
    fi

    echo "✅ File size matches: 256 bytes."
    # key1-1
    #local OFFSETS=(128 129 0 1)
    # key1-2
    #local OFFSETS=(144 145 16 17)
    # key1-3
    #local OFFSETS=(160 161 32 33)

    # key2-1 key value 1hex offset 6 (129 offset buyt 6) then 136
    # 
    #local OFFSETS=(136 137 8 9)
    # key2-2  (offset first key + 32 + 1)
    #local OFFSETS=(168 169 40 41)
    # key2-3  (offset 2nd key + 6 offset value + 1)
    local OFFSETS=(176 177 48 49)

    # key3-1
    #local OFFSETS=(148 149 20 21)
    # 3-2
    #local OFFSETS=(164 165 36 37)
    # 3-3
    #local OFFSETS=(180 181 52 53)

    for OFFSET in "${OFFSETS[@]}"; do
        if [ "$OFFSET" -ge "$FILESIZE" ]; then
            echo "⚠️ Offset $OFFSET is out of range."
            continue
        fi
        local BYTE
        BYTE=$(dd if="$FILE" bs=1 skip="$OFFSET" count=1 2>/dev/null | xxd -p)
        echo -n "$BYTE"
    done
    echo ""
}
alias q="readbin"








