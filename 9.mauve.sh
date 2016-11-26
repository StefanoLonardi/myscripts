#/bin/csh
export A=/home/stelo/cowpea_assemblies/91x/abruijn49x_corrected_k19_cov49/abruijn49x_corrected_k19_cov49.fasta
export B=/home/stelo/cowpea_assemblies/91x/canu91x_low_outcov100/canu91x_low_outcov100.fasta
export C=/home/stelo/cowpea_assemblies/91x/canu91x_high_erate0.15_outcov100/canu91x_high_erate0.15_outcov100.fasta
export COMMONBEAN=/home/stelo/other_legumes/P.vulgaris_commonbean/Pvulgaris_218_v1.0.fa
export ADZUKIBEAN=/home/stelo/other_legumes/Vigna_angularis_adzukibean/adzuki.ver3.ref.fa.cor.fa
export MUNGBEAN=/home/stelo/other_legumes/Vigna_radiata_mungbean/Vradi.ver6.cor.fa
export SOYBEAN=/home/stelo/other_legumes/G.max.Wm82.a2.v1_soybean/Gmax_275_v2.0.fa
export A=./contig1_abruijn49x.fasta
export B=./contig1_canu91xlow.fasta
export C=./contig1_falcon49x.fasta

#/home/hind/.usr/local/mauve/linux-x64/progressiveMauve --output=fourway.xmfa --output-guide-tree=fourway.tree --backbone-output=fourway.backbone $COMMONBEAN $A $B $C
/home/hind/.usr/local/mauve/linux-x64/progressiveMauve --output=threeway.xmfa --output-guide-tree=threeway.tree --backbone-output=threeway.backbone $A $B $C
#/home/hind/.usr/local/mauve/linux-x64/progressiveMauve --output=twoway.xmfa --output-guide-tree=twoway.tree --backbone-output=twoway.backbone $A $B

