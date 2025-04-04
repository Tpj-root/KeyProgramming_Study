#!/bin/bash
##########################################################
#/*
# * Copyright (C) 2025 [Tpj-root]
# * https://github.com/Tpj-root
# *
# * This program is free software; you can redistribute it and/or modify
# * it under the terms of the GNU General Public License version 2
# * as published by the Free Software Foundation.
# *
# * This program is distributed in the hope that it will be useful,
# * but WITHOUT ANY WARRANTY; without even the implied warranty of
# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# * GNU General Public License for more details.
# *
# * You should have received a copy of the GNU General Public License
# * along with this program; if not, see <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>.
# */
# version_1.0
##########################################################
vehicle_info() {
    echo "----------------------------------"
    echo -n "Help Information : "
    echo "Toyota, Corolla, -2004, 93C56, ECU"
    echo "EEPROM :: 93C56"
    echo "SIZE   :: 256 Bytes"
    echo "----------------------------------"
}

check_file_size() {
    local FILE=$1
    shift

    local FILESIZE
    FILESIZE=$(stat -c %s "$FILE" 2>/dev/null)

    if [ -z "$FILESIZE" ]; then
        echo "❌ Error: File not found or inaccessible: $FILE"
        return 1
    fi

    if [ "$FILESIZE" -eq 256 ]; then
        echo "✅ File '$FILE' size matches: 256 bytes."
    else
        echo "❌ Error: File '$FILE' size is $FILESIZE bytes, expected 256 bytes."
        return 1
    fi
}


keyvalue() {

    if [ $# -lt 2 ]; then
        echo "Usage: keyvalue <file.bin> <offset1> [offset2] [offset3] ..."
        return 1
    fi

    local FILE=$1
    shift

    local FILESIZE
    FILESIZE=$(stat -c %s "$FILE" 2>/dev/null)

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


FILENAME_0=./BIN_FILES/Toyota_/Corolla/Data_set_0/AT93C56_EEPROM.bin
FILENAME_1=./BIN_FILES/Toyota_/Corolla/Data_set_1/ATMEL_AT93C56_EEPROM20230131145146_Read.bin
FILENAME_2=./BIN_FILES/Toyota_/Corolla/Data_set_2/ATMEL_AT93C56_EEPROM20250402152555_Read.bin
FILENAME_3=./BIN_FILES/Toyota_/Corolla/Data_set_3/ATMEL_AT93C56_EEPROM20250403100253_Read.bin 


vehicle_info
check_file_size "${FILENAME_0}"
echo "----------------------------------"
echo -n "Key 1  : ID : "
keyvalue "${FILENAME_0}" 128 129 0 1 | tr '[:lower:]' '[:upper:]'
echo -n "Key 2  : ID : "
keyvalue "${FILENAME_0}" 136 137 8 9 | tr '[:lower:]' '[:upper:]'
echo -n "Key 3  : ID : "
keyvalue "${FILENAME_0}" 148 149 20 21 | tr '[:lower:]' '[:upper:]'
echo "----------------------------------"
check_file_size "${FILENAME_1}"
echo "----------------------------------"
echo -n "Key 1  : ID : "
keyvalue "${FILENAME_1}" 128 129 0 1 | tr '[:lower:]' '[:upper:]'
echo -n "Key 2  : ID : "
keyvalue "${FILENAME_1}" 136 137 8 9 | tr '[:lower:]' '[:upper:]'
echo -n "Key 3  : ID : "
keyvalue "${FILENAME_1}" 148 149 20 21 | tr '[:lower:]' '[:upper:]'
echo "----------------------------------"
check_file_size "${FILENAME_2}"
echo "----------------------------------"
echo -n "Key 1  : ID : "
keyvalue "${FILENAME_2}" 128 129 0 1 | tr '[:lower:]' '[:upper:]'
echo -n "Key 2  : ID : "
keyvalue "${FILENAME_2}" 136 137 8 9 | tr '[:lower:]' '[:upper:]'
echo -n "Key 3  : ID : "
keyvalue "${FILENAME_2}" 148 149 20 21 | tr '[:lower:]' '[:upper:]'
echo "----------------------------------"
check_file_size "${FILENAME_3}"
echo "----------------------------------"
echo -n "Key 1  : ID : "
keyvalue "${FILENAME_3}" 128 129 0 1 | tr '[:lower:]' '[:upper:]'
echo -n "Key 2  : ID : "
keyvalue "${FILENAME_3}" 136 137 8 9 | tr '[:lower:]' '[:upper:]'
echo -n "Key 3  : ID : "
keyvalue "${FILENAME_3}" 148 149 20 21 | tr '[:lower:]' '[:upper:]'
echo "----------------------------------"