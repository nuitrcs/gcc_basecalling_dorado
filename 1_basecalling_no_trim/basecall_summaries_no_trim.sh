#!/bin/bash
#SBATCH --account=e32559
#SBATCH --partition=short
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1    
#SBATCH --mem=10G
#SBATCH --job-name=basecall_no_trim_summary
#SBATCH --out=./logs/basecall_no_trim_summary-slurm-%j.out

# Define output paths to analyze

DATA_DIR=./output
model_tag=hac

echo "Path: $DATA_DIR"
echo "Model tag: $model_tag"

# Load dorado module 
module load dorado/2.1.1

# summary
dorado summary -r "./$DATA_DIR" > "./$DATA_DIR/summary-$model_tag.tsv"

# visualize performance with pycoqc
module purge
module load mamba/24.3.0
eval "$('/hpc/software/mamba/24.3.0/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
source "/hpc/software/mamba/24.3.0/etc/profile.d/mamba.sh"
mamba activate /gpfs/projects/e32559/05_dorado/virtual_environments/pycoqc_env

# visualize summary
pycoQC -f "./$DATA_DIR/summary-$model_tag.tsv" -o "./$DATA_DIR/pycoQC_output-$model_tag.html"
 
 
