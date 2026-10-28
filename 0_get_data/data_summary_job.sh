#!/bin/bash
#SBATCH --account=e32559 
#SBATCH --partition=short
#SBATCH --time=01:00:00   
#SBATCH --nodes=1  
#SBATCH --ntasks-per-node=4
#SBATCH --mem=15G
#SBATCH --job-name=pod5_summary_job
#SBATCH --output=/projects/a9009/tdm5510/workshops/gpu_dorado_genomics_112026/data/logs/pod5_summary_job-slurm-%j.out

# Following view tool syntax explained here:
# https://software-docs.nanoporetech.com/pod5/latest/tools/

# Load pod5 module 
module load pod5/0.3.49

WORKING_DIR=/projects/a9009/tdm5510/workshops/gpu_dorado_genomics_112026/data
DATASET=fungal_ITS_2025.09

# Run summary command

export POD5_DEBUG=1
echo "SLURM ntasks: $SLURM_NTASKS"

pod5 inspect summary $WORKING_DIR/$DATASET/raw/*.pod5

pod5 view $WORKING_DIR/$DATASET/raw/*.pod5 --force-overwrite --threads=$SLURM_NTASKS --output $WORKING_DIR/output/$DATASET-summary.tsv


