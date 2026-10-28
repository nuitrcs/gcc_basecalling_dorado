#!/bin/bash
##SBATCH --account=e32559
##SBATCH --partition=short
#SBATCH --account=a9009
#SBATCH --partition=a9009
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=16G
#SBATCH --job-name=demux_sup_no_trim
#SBATCH --out=./logs/demux_sup_no_trim-slurm-%j.out

# Load dorado module 
module load dorado/2.1.1

# Define directories
BASE_DIR=../basecalling_no_trim/output/sup
OUT_DIR=./output

## Kit from here and dorado demux --help 
# https://epi2me.nanoporetech.com/fungal_its_2025.09/#preparation
MY_KIT=SQK-MAB114-24

dorado demux "$BASE_DIR" -r --no-trim --kit-name "$MY_KIT" --output-dir "$OUT_DIR"


# A different worse way to do it when there were singularity bind paths missing 
# ## Demux in a loop
# # Find all BAM files
# mapfile -t BAM_FILES < <(find "$BASE_DIR" -type f -name '*.bam')

# # Print the BAM files
# echo "Found files: "
# printf '%s\n' "${BAM_FILES[@]}"

# # Demux each BAM separately
# for bam in "${BAM_FILES[@]}"; do
#     bam_name=$(basename "$bam" .bam)

# 	echo "Demuxing: $bam"
# 	echo "Output: $OUT_DIR/$bam_name"

#     dorado demux "$bam" \
#         --no-trim \
#         --kit-name "$MY_KIT" \
#         --output-dir "$OUT_DIR/$bam_name"

# done



