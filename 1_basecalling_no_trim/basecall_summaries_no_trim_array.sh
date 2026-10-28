#!/bin/bash
##SBATCH --account=e32559
##SBATCH --partition=gengpu
#SBATCH --account=a9009
#SBATCH --partition=a9009
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1    
#SBATCH --mem=10G
#SBATCH --array=0-2
#SBATCH --job-name=basecall_no_trim_summary_array
#SBATCH --out=./logs/basecall_no_trim_summary_array-slurm-%A_%a.out

# Define output paths to analyze

paths=("output/fast" "output/hac" "output/sup")
model_tags=("fast" "hac" "sup")
current_path="${paths[$SLURM_ARRAY_TASK_ID]}"
current_tag="${model_tags[$SLURM_ARRAY_TASK_ID]}"

echo "Array task: $SLURM_ARRAY_TASK_ID"
echo "Path: $current_path"
echo "Model tag: $current_tag"

# Load dorado module 
module load dorado/2.1.1

# summary
dorado summary -r "./$current_path" > "./$current_path/summary-$current_tag.tsv"

# visualize performance with pycoqc
module purge
module load mamba/24.3.0
eval "$('/hpc/software/mamba/24.3.0/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
source "/hpc/software/mamba/24.3.0/etc/profile.d/mamba.sh"
mamba activate /gpfs/projects/a9009/tdm5510/workshops/gpu_dorado_genomics_112026/pycoqc_env

# visualize summary
pycoQC -f "./$current_path/summary-$current_tag.tsv" -o "./$current_path/pycoQC_output-$current_tag.html"
 


