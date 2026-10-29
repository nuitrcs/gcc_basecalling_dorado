#!/bin/bash
#SBATCH --account=e32559 
#SBATCH --partition=short
#SBATCH --time=01:00:00   
#SBATCH --nodes=1  
#SBATCH --ntasks-per-node=1
#SBATCH --mem=5G
#SBATCH --job-name=pod5_plot_job
#SBATCH --output=./logs/pod5_plot_job-slurm-%j.out

# Running plotting script provided here: 
# https://software-docs.nanoporetech.com/pod5/latest/reading/#plotting-example

# Load pod5 module 
module load pod5/0.3.49

python ./plot_read_signal.py



