#!/bin/bash
#SBATCH --job-name=braker2_eupsc_rnaseq_isoseq_prot
#SBATCH --cpus-per-task=48
#SBATCH --mem=80GB
#SBATCH --time=10-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --partition=himem
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err


module load conda
conda activate braker 
thread=48

braker.pl --cores 48 --genome=Lachesis_assembly.fasta --softmasking --gff3 --etpmode --AUGUSTUS_CONFIG_PATH=./config  --GENEMARK_PATH=./genemark/gmes_linux_64_4 --PROTHINT_PATH=./genemark/gmes_linux_64_4/ProtHint/bin --prot_seq=bfl.prot,obi.prot,pmax2.prot,dpe.prot,naut.prot --bam=merged_isoseq_scolopes.bam,167718_S3_Aligned.sortedByCoord.out.bam,167722_S7_Aligned.sortedByCoord.out.bam,167717_S2_Aligned.sortedByCoord.out.bam,167721_S6_Aligned.sortedByCoord.out.bam,167716_S1_Aligned.sortedByCoord.out.bam,167723_S8_Aligned.sortedByCoord.out.bam,167719_S4_Aligned.sortedByCoord.out.bam,167724_S9_Aligned.sortedByCoord.out.bam,167720_S5_Aligned.sortedByCoord.out.bam,167727_S12_Aligned.sortedByCoord.out.bam,167726_S11_Aligned.sortedByCoord.out.bam,190909_S8_Aligned.sortedByCoord.out.bam,190908_S7_Aligned.sortedByCoord.out.bam,190907_S6_Aligned.sortedByCoord.out.bam,167741_S26_Aligned.sortedByCoord.out.bam

