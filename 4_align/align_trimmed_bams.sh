#!/bin/bash
#SBATCH --account=e32559
#SBATCH --partition=short
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1    
#SBATCH --mem=10G
#SBATCH --job-name=align_trimmed
#SBATCH --out=./logs/align_trimmed-slurm-%j.out

# Define output paths to analyze
# Make sure the reference fasta exists in the 
# right location before running this job 
BASE_DIR="../2_demux_no_trim/output"
OUT_DIR="./output"
REF_FASTA="./sh_general_release_dynamic_19.02.2025.fasta"

# Find all trimmed BAM files
mapfile -t BAM_FILES < <(find "$BASE_DIR" -type f -name '*-trimmed.bam')

# Print the trimmed BAM files
echo "Found trimmed files: "
printf '%s\n' "${BAM_FILES[@]}"

# Load software
module purge
module load dorado/2.1.1

# Align and summarize each BAM separately
for bam in "${BAM_FILES[@]}"; do

	# align
	echo "Aligning: $bam"
	dorado aligner "$REF_FASTA" "$bam" --output-dir "$OUT_DIR" --emit-summary

done

