#!/bin/bash
#SBATCH --account=e32559
#SBATCH --partition=data-transfer
#SBATCH --time=01:00:00
#SBATCH --nodes=1  
#SBATCH --ntasks-per-node=1    
#SBATCH --mem=5G
#SBATCH --job-name=aws_ont_open_data_download 
#SBATCH --out=./logs/aws_ont_open_data_download-slurm-%j.out

## Following instructions for open dataset here:
## https://epi2me.nanoporetech.com/fungal_its_2025.09/

# Load AWS CLI module 
module load awscli/2.15.22

# Define directory
DOWNLOAD_DIR=./output

# Download data 
aws s3 cp --no-sign-request s3://ont-open-data/fungal_ITS_2025.09/raw/T1_B1_pod5_subset_ITS_FBB34176.pod5 "$DOWNLOAD_DIR/T1_B1_pod5_subset_ITS_FBB34176.pod5"
