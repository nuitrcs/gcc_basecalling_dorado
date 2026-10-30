#!/bin/bash
#SBATCH --account=e32559
#SBATCH --partition=gengpu
#SBATCH --time=00:20:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1    
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --job-name=basecall_no_trim
#SBATCH --out=./logs/basecall_no_trim-slurm-%j.out

# Define model
model="dna_r10.4.1_e8.2_400bps_hac@v6.0.0"
model_tag="hac"

# Define directories
MODEL_DIR=./models
DATA_DIR=/projects/e32559/05_dorado/shared_data
OUT_DIR=./output

echo "Model tag: $model_tag"
echo "Model: $MODEL_DIR/$model"

# Check GPU
nvidia-smi

# Load dorado module 
module load dorado/2.1.1

# Basecall
dorado basecaller "$MODEL_DIR/$model" $DATA_DIR --no-trim --device cuda:all --output-dir "$OUT_DIR"


