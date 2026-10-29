#!/bin/bash
#SBATCH --account=e32559 
#SBATCH --partition=short
#SBATCH --time=01:00:00   
#SBATCH --nodes=1  
#SBATCH --ntasks-per-node=2
#SBATCH --mem=10G
#SBATCH --job-name=pod5_summary_job
#SBATCH --output=./logs/pod5_summary_job-slurm-%j.out

# Following view tool syntax explained here:
# https://software-docs.nanoporetech.com/pod5/latest/tools/

# Load pod5 module 
module load pod5/0.3.49

DATA_DIR=./output

# Run summary command
export POD5_DEBUG=1
echo "SLURM ntasks: $SLURM_NTASKS"

pod5 inspect summary $DATA_DIR/*.pod5

pod5 view $DATA_DIR/*.pod5 --force-overwrite --threads=$SLURM_NTASKS --output $DATA_DIR/pod5-summary.tsv

