## UNITE 
# https://unite.ut.ee/index.php
# https://doi.plutof.ut.ee/doi/10.15156/BIO/3301229

# Download in web browser and upload to Quest with Globus

# Extract with tar command 
tar -xvzf sh_general_release_19.02.2025.tgz

# View the top of the extracted .fasta file:
$ head sh_general_release_dynamic_19.02.2025.fasta 
>Abrothallus_subhalei|MT153946|SH1227328.10FU|refs|k__Fungi;p__Ascomycota;c__Dothideomycetes;o__Abrothallales;f__Abrothallaceae;g__Abrothallus;s__Abrothallus_subhalei
CAACCCTTGCTTACCTACCACGTTGCTTCGGCGGGCCCGGGGCAAGCCCCCCGCCCTCGCGGGCGCGCGCCCGCCGGAGGCCAACCAAACTCTGATCAGCGACTGTCTGAGCGAAT
>Mucor_inaequisporus|JN206177|SH1227742.10FU|refs|k__Fungi;p__Mucoromycota;c__Mucoromycetes;o__Mucorales;f__Mucoraceae;g__Mucor;s__Mucor_inaequisporus
ATCATTAAATAATTTGATAATTAYACAATTATCTAATTTACTGTGAACTGTTTTATTCATGACGCTATGGGGATGACTGCATGCCATAAGGGTAGGTACGCAGAATGTTAACCTA
>Candida_vrieseae|KY102517|SH1232203.10FU|refs|k__Fungi;p__Ascomycota;c__Saccharomycetes;o__Saccharomycetales;f__Saccharomycetales_fam_Incertae_sedis;g__Candida;s__Candida_vrieseae

## The steps below are optional because dorado/minimap2 can use fasta as a reference as well as mmi
https://software-docs.nanoporetech.com/dorado/latest/basecaller/alignment/#aligning-existing-basecalls
https://lh3.github.io/minimap2/minimap2.html

# Start interactive job on compute node 
$ srun --account=e32559 --partition=short -N 1 -n 1 --mem=10G --time=01:00:00 --pty bash -l

# Load dorado module 
$ module load dorado/2.1.1

# Run minimap2 (provided with dorado) to produce from the .fast a .mmi reference (index) for minimap2
$ minimap2 -d sh_general_release_dynamic_19.02.2025.mmi sh_general_release_dynamic_19.02.2025.fasta
[M::mm_idx_gen::1.770*0.97] collected minimizers
[M::mm_idx_gen::2.604*0.98] sorted minimizers
[M::main::2.785*0.98] loaded/built the index for 102137 target sequence(s)
[M::mm_idx_stat] kmer size: 15; skip: 10; is_hpc: 0; #seq: 102137
[M::mm_idx_stat::2.821*0.98] distinct minimizers: 2748821 (69.76% are singletons); average occurrences: 3.575; average spacing: 5.588; total length: 54906744
[M::main] Version: 2.28-r1209
[M::main] CMD: /opt/custflow/epi2meuser/conda/bin/minimap2 -d sh_general_release_dynamic_19.02.2025.mmi sh_general_release_dynamic_19.02.2025.fasta
[M::main] Real time: 2.832 sec; CPU: 2.765 sec; Peak RSS: 0.407 GB

# Computationally this does not seem worth it, so we will pass dorado the .fasta  



