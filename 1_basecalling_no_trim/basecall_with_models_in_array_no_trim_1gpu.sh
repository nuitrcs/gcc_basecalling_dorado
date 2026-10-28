#!/bin/bash
##SBATCH --account=e32559
##SBATCH --partition=gengpu
#SBATCH --account=a9009
#SBATCH --partition=a9009
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1    
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --array=0-2
#SBATCH --job-name=basecall_no_trim_array
#SBATCH --out=./logs/basecall_no_trim_array-slurm-%A_%a.out

# Define models and which model will be used for each array job

models=("dna_r10.4.1_e8.2_400bps_fast@v5.2.0" "dna_r10.4.1_e8.2_400bps_hac@v6.0.0" "dna_r10.4.1_e8.2_400bps_sup@v5.2.0")
model_tags=("fast" "hac" "sup")
current_model_tag="${model_tags[$SLURM_ARRAY_TASK_ID]}"
current_model="${models[$SLURM_ARRAY_TASK_ID]}"

echo "Array task: $SLURM_ARRAY_TASK_ID"
echo "Model tag: $current_model_tag"
echo "Model: $current_model"

# Check GPU
nvidia-smi

# Load dorado module 
module load dorado/2.1.1

# Define directories
MODEL_DIR=./models
DATA_DIR=/projects/a9009/tdm5510/workshops/gpu_dorado_genomics_112026/data/fungal_ITS_2025.09/raw
OUT_DIR=./output

mkdir -p "$OUT_DIR/$current_model_tag"

# Basecall
dorado basecaller "$MODEL_DIR/$current_model" $DATA_DIR --no-trim --device cuda:all --output-dir "$OUT_DIR/$current_model_tag"



