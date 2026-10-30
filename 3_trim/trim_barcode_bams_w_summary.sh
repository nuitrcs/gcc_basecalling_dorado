#!/bin/bash
#SBATCH --account=e32559
#SBATCH --partition=short
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1    
#SBATCH --mem=10G
#SBATCH --job-name=trim_plus_summary
#SBATCH --out=./logs/trim_plus_summary-slurm-%j.out

# Define output paths to analyze
BASE_DIR="../2_demux_no_trim/output"
OUT_DIR="./output/trim_summaries"

mkdir -p "$OUT_DIR"

# Find all BAM files
mapfile -t BAM_FILES < <(find "$BASE_DIR" -type f -name '*.bam')

# Print the BAM files
echo "Found files: "
printf '%s\n' "${BAM_FILES[@]}"

## Kit from here and dorado demux --help 
# https://epi2me.nanoporetech.com/fungal_its_2025.09/#preparation
MY_KIT=SQK-MAB114-24

# Load software
module purge
module load dorado/2.1.1

module load mamba/24.3.0
eval "$('/hpc/software/mamba/24.3.0/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
source "/hpc/software/mamba/24.3.0/etc/profile.d/mamba.sh"
mamba activate /gpfs/projects/e32559/05_dorado/virtual_environments/pycoqc_env

# Trim and summarize each BAM separately
for bam in "${BAM_FILES[@]}"; do
    bam_name=$(basename "$bam" .bam)
	bam_dir="${bam%/*}"

	echo "Directory: $bam_dir"
	echo "Trimming: $bam"
	
	# trim
	dorado trim "$bam" --sequencing-kit $MY_KIT > "$bam_dir/$bam_name-trimmed.bam"

	echo "Summarizing: $bam"

	# summary
	dorado summary "$bam_dir/$bam_name-trimmed.bam" > "$OUT_DIR/summary-$bam_name-trimmed.tsv"

	# visualize summary
	pycoQC -f "$OUT_DIR/summary-$bam_name-trimmed.tsv" -o "$OUT_DIR/pycoQC_output-$bam_name-trimmed.html"

done



