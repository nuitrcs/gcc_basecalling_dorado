#!/bin/bash
#SBATCH --account=e32559
#SBATCH --partition=short
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=16G
#SBATCH --job-name=demux_no_trim
#SBATCH --out=./logs/demux_no_trim-slurm-%j.out

# Load dorado module 
module load dorado/2.1.1

# Define directories
BASE_DIR=../1_basecalling_no_trim/output
OUT_DIR=./output

## Kit from here and dorado demux --help 
# https://epi2me.nanoporetech.com/fungal_its_2025.09/#preparation
MY_KIT=SQK-MAB114-24

dorado demux "$BASE_DIR" -r --no-trim --kit-name "$MY_KIT" --output-dir "$OUT_DIR"

