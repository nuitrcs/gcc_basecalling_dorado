#!/bin/bash
#SBATCH --account=e32559
#SBATCH --partition=short
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1    
#SBATCH --mem=10G
#SBATCH --job-name=demux_no_trim_summary
#SBATCH --out=./logs/demux_no_trim_summary-slurm-%j.out

# Define output paths to analyze
BASE_DIR="./output"
OUT_DIR="./output/demux_summaries"

mkdir -p "$OUT_DIR"

# Find all BAM files
mapfile -t BAM_FILES < <(find "$BASE_DIR" -type f -name '*.bam')

# Print the BAM files
echo "Found files: "
printf '%s\n' "${BAM_FILES[@]}"

# Load software
module purge
module load dorado/2.1.1

module load mamba/24.3.0
eval "$('/hpc/software/mamba/24.3.0/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
source "/hpc/software/mamba/24.3.0/etc/profile.d/mamba.sh"
mamba activate /gpfs/projects/e32559/05_dorado/virtual_environments/pycoqc_env

# Summarize each BAM separately
for bam in "${BAM_FILES[@]}"; do
    bam_name=$(basename "$bam" .bam)

	echo "Summarizing: $bam"
	
	# summary
	dorado summary "$bam" > "./$OUT_DIR/summary-$bam_name.tsv"

	# visualize summary
	pycoQC -f "./$OUT_DIR/summary-$bam_name.tsv" -o "./$OUT_DIR/pycoQC_output-$bam_name.html"

done



