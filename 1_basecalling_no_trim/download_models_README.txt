## Downloading models with dorado download 
1. Start an interactive session on a compute node 
srun --account=e32559 --partition=short -N 1 -n 1 --mem=10G --time=01:00:00 --pty bash -l

2. Once you are in the interactive session, load the dorado module 
module load dorado/2.1.1

3. Navigate to your basecalling folder 
cd /projects/e32559/<YOUR_NAME>/05_dorado/basecalling

4. Create an environmental variable containing the path to where our pod5 data is
export DATA_DIR=/projects/a9009/tdm5510/workshops/gpu_dorado_genomics_112026/data/fungal_ITS_2025.09/raw

5. Check that the previous step worked 
echo $DATA_DIR 
ls $DATA_DIR

6. We want to download three models: fast, hac (high-accuracy), and sup (super-accurate).
   Within the three model speeds/accuracies, there are also other sequencing conditions  
   that make different models appropriate for different data. Dorado will choose the  
   model for us if we provide the data and the desired model speed/accuracy. Download 
   the fast model for our data and direct the download to the models subdirectory of your  
   basecalling folder. We are using the environmental variable we created to point to 
   our pod5 data. 
dorado download --model fast --data $DATA_DIR --models-directory ./models

7. Repeat the above step for hac and sup
dorado download --model hac --data $DATA_DIR --models-directory ./models
dorado download --model sup --data $DATA_DIR --models-directory ./models

8. View the contents of your models folder 
ls models

