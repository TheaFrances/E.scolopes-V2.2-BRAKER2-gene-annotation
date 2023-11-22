**Euprymna scolopes gene annotation for V2 genome (after Sci Data revision)**  

This repo contains the gene annotation (new BRAKER2 models, combined with some genes from Belcaid et al. 2019) for the Hawaiian bobtail squid, Euprymna scolopes genome (Schmidbaur et al., 2022). It is part of the following manuscript, in revision at Scientific data: Towards a comprehensive gene annotation for the Hawaiian bobtail squid, Euprymna scolopes. Thea F. Rogers, Gözde Yalçın, John Briseno, Nidhi Vijayan, Spencer V. Nyholm, Oleg Simakov.  

**The annotation files are as follows:**  
eupsc_models_v2.2.gtf #Gene annotation GTF  
eupsc_models_v2.2_cds.fa #Coding sequence file  
eupsc_models_v2.2_prot.fa #Protein sequence file  
eupsc_models_v2.2_interproscan.tsv #Protein annotation  

**List of commands used to generate the annotation can be found in these files:**  
1. Iso-Seq processing and mapping  
2. Run BRAKER2, format output and run BUSCO  
3. Add Belcaid models missed in BRAKER, run BUSCO and Interproscan and count orthologs  
  
TSEBRA was also run to select the best genes from Iso-Seq data and BRAKER2 models as suggested by reviewer 2. However, this decreased BUSCO completeness scores so was not used in the final annotation. **The commands run, and gtf output from TSEBRA (for reviewers only) can be found here:**  
4. TSEBRA  
tsebra_withGushr_longread.gtf

**Scripts used are as follows:**  
braker2_eupsc_isoseq_rnaseq_prot.sh #BRAKER2 SLURM script 1 for making gene models with RNA-seq, Iso-Seq from  E. scolopes and protein files from other species    
braker2_eupsc_isoseq_rnaseq_utron.sh #BRAKER2 SLURM script 2 for adding UTRs to the output of the first BRAKER2 script above  
convertBraker2Gff.pl #Script for formatting BRAKER2 output gtf  
obtainBelcaidGeneList3.pl #Script for creating non-overlapping (more than 75% of exons unique) and multi-exon Belcaid genes  
countExonPerGene.pl #Count number of multi- and single-exon genes that are annotated and annotated in Interproscan  





