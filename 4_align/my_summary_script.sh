#!/bin/bash

# Check that a BAM file was provided
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 /full/path/to/file.bam"
    exit 1
fi

BAM="$1"

# Check that the BAM exists
if [[ ! -f "$BAM" ]]; then
    echo "Error: BAM file not found: $BAM"
    exit 1
fi

# Create output filename from BAM filename
BASENAME=$(basename "$BAM" .bam)
OUTPUT="$(dirname "$BAM")/${BASENAME}_simple_summary.tsv"

# Total number of primary mapped reads
total=$(samtools view -c -F 0x904 "$BAM")

# Write header
printf "Count\tPercent\tSpecies\n" > "$OUTPUT"

# Count primary mapped reads by species
samtools view -F 0x904 "$BAM" |
    cut -f3 |
    sort |
    uniq -c |
    sort -nr |
    head |
    while read -r count ref; do

        species=$(echo "$ref" | sed -n 's/.*s__\([^;]*\).*/\1/p')

        percent=$(awk -v count="$count" -v total="$total" \
            'BEGIN {printf "%.2f", (count / total) * 100}')

        printf "%d\t%s\t%s\n" \
            "$count" "$percent" "$species"

    done >> "$OUTPUT"

echo "Wrote results to $OUTPUT"

