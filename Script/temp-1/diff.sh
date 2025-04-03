#!/bin/bash

# Ensure 4 files are given
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 file1.bin file2.bin file3.bin file4.bin"
    exit 1
fi

# Read files into arrays
for i in {1..4}; do
    readarray -t "data_$i" < <(od -An -t x1 -v "${!i}" | tr -s ' ' | tr ' ' '\n')
done

# Compare byte by byte
echo "Byte Position | ${1} | ${2} | ${3} | ${4}"
echo "-------------|------|------|------|------"

for i in {0..255}; do
    val1=${data_1[i]:-00}
    val2=${data_2[i]:-00}
    val3=${data_3[i]:-00}
    val4=${data_4[i]:-00}

    # Check if any values are different
    if [[ "$val1" != "$val2" || "$val1" != "$val3" || "$val1" != "$val4" ]]; then
        printf "%12d | %2s | %2s | %2s | %2s\n" "$i" "$val1" "$val2" "$val3" "$val4"
    fi
done
