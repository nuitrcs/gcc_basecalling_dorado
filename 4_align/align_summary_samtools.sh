#!/bin/bash
#SBATCH --account=e32559
#SBATCH --partition=short
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1    
#SBATCH --mem=10G
#SBATCH --job-name=simple_summary_align
#SBATCH --out=./logs/simple_summary_align-slurm-%j.out

# Define output paths to analyze
BASE_DIR="./output"

# Find all aligned BAM files
mapfile -t BAM_FILES < <(find "$BASE_DIR" -type f -name '*.bam')

# Print the aligned BAM files
echo "Found aligned files: "
printf '%s\n' "${BAM_FILES[@]}"

# Load software
module purge
module load samtools/1.24

# Align and summarize each BAM separately
for bam in "${BAM_FILES[@]}"; do
	bam_name=$(basename "$bam" .bam)
	bam_dir="${bam%/*}"

	echo "Directory: $bam_dir"
	echo "Summarizing: $bam_name"

	bash ./my_summary_script.sh $bam

done


