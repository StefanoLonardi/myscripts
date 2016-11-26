#/bin/csh
# rm *.amb *.ann *.bwt *.pac *.sa *.fai
# ------- COMMANDS
export BWA=/home/stelo/bwa/bwa
export SAMTOOLS=/home/stelo/bin/samtools
# ------- DATA
export BACS=/home/stelo/CANU_in_progress/BACs.4.2.fasta
export UCR1=/home/stelo/CANU_in_progress/UCR2014_1.qv23.f70.align.fastq
export UCR2=/home/stelo/CANU_in_progress/UCR2014_2.qv23.f70.align.fastq
export VU1_1=/home/stelo/CANU_in_progress/vu1_all_1.fastq.gz
export VU1_2=/home/stelo/CANU_in_progress/vu1_all_2.fastq.gz
export VU2_1=/home/stelo/CANU_in_progress/vu2_all_1.fastq.gz
export VU2_2=/home/stelo/CANU_in_progress/vu2_all_2.fastq.gz
export LIPE1=/home/stelo/CANU_in_progress/ncgr_lipe/s_6_1.trim.far36.sort.aligned
export LIPE2=/home/stelo/CANU_in_progress/ncgr_lipe/s_6_2.trim.far36.sort.aligned
export TRANS=/home/stelo/CANU_in_progress/transcripts.fasta
export SOAP=/home/stelo/CANU_in_progress/filtered500.soapcontig.fasta.gz
# ------- REFERENCE
export DATASET=canu91x_high_outcov100
export DI=/home/stelo/cowpea_assemblies/91x/$DATASET
export REF=$DI/$DATASET.fasta
export THREADS=12
# ------- OUTPUT FILES
export BACSO=$DI/BACS_2_$DATASET
export UCRO=$DI/UCR2014_2_$DATASET
export VU1O=$DI/VU1_2_$DATASET
export VU2O=$DI/VU2_2_$DATASET
export LIPEO=$DI/LIPE_2_$DATASET
export TRANSO=$DI/transcripts_2_$DATASET
export SOAPO=$DI/filtered500.soapcontig_2_$DATASET

# ------- INDEXING THE REFERENCE
$BWA index $REF
$SAMTOOLS faidx $REF

# ------- BACs vs CONTIGS
$BWA mem -t $THREADS $REF $BACS > $BACSO.sam
$SAMTOOLS view -bT $REF $BACSO.sam > $BACSO.bam
#$SAMTOOLS flagstat $BACSO.bam
#$SAMTOOLS view -q 30 -c $BACSO.bam
#$SAMTOOLS sort -m10G -T /tmp/aln.sorted -o $BACSO.sorted.bam $BACSO.bam

# ------- TRANSCRIPTS vs CONTIGS
$BWA mem -t $THREADS $REF $TRANS > $TRANSO.sam
$SAMTOOLS view -bT $REF $TRANSO.sam > $TRANSO.bam
# $SAMTOOLS flagstat $TRANSO.bam
# $SAMTOOLS view -q 30 -c $TRANSO.bam
# $SAMTOOLS sort -m10G -T /tmp/aln.sorted -o $TRANSO.sorted.bam $TRANSO.bam

# ------- SOAP vs CONTIGS
$BWA mem -t $THREADS $REF $SOAP > $SOAPO.sam
$SAMTOOLS view -bT $REF $SOAPO.sam > $SOAPO.bam
# $SAMTOOLS flagstat $SOAPO.bam
# $SAMTOOLS view -q 30 -c $SOAPO.bam
# $SAMTOOLS sort -m10G -T /tmp/aln.sorted -o $SOAPO.sorted.bam $SOAPO.bam

# ------- UCR2014 reads vs CONTIGS
$BWA mem -t $THREADS $REF $UCR1 $UCR2 > $UCRO.sam
$SAMTOOLS view -bT $REF $UCRO.sam > $UCRO.bam
# $SAMTOOLS flagstat $UCRO.bam
# $SAMTOOLS view -q 30 -c $UCRO.bam
# $SAMTOOLS view -bq 20 $UCRO.bam > $UCRO.q20.bam
# $SAMTOOLS sort -m10G -T /tmp/aln.sorted -o $UCRO.sorted.bam $UCRO.bam

# --------------------------
# -------- PILON -----------
# --------------------------

# ------- VU1 reads vs CONTIGS
# $BWA mem -t $THREADS $REF $VU1_1 $VU1_2 > $VU1O.sam
# $SAMTOOLS view -bT $REF $VU1O.sam > $VU1O.bam
# $SAMTOOLS flagstat $VU1O.bam
# $SAMTOOLS view -q 30 -c $VU1O.bam
# $SAMTOOLS sort -m10G -T /tmp/aln.sorted -o $VU1O.sorted.bam $VU1O.bam

# ------- VU2 reads vs CONTIGS
# $BWA mem -t $THREADS $REF $VU2_1 $VU2_2 > $VU2O.sam
# $SAMTOOLS view -bT $REF $VU2O.sam > $VU2O.bam
# $SAMTOOLS flagstat $VU2O.bam
# $SAMTOOLS view -q 30 -c $VU2O.bam
# $SAMTOOLS sort -m10G -T /tmp/aln.sorted -o $VU2O.sorted.bam $VU2O.bam

# ------- MERGE UCR2014, VU1 and VU2
# $SAMTOOLS merge $DI/vu_all.sorted.bam $VU1O.sorted.bam $VU2O.sorted.bam $UCRO.sorted.bam

# ------- NCGR LIPE reads vs CONTIGS
# $BWA mem -t $THREADS $REF $LIPE1 $LIPE2 > $LIPEO.sam
# $SAMTOOLS view -bT $REF $LIPEO.sam > $LIPEO.bam
# $SAMTOOLS flagstat $LIPEO.bam
# $SAMTOOLS view -q 30 -c $LIPEO.bam
# $SAMTOOLS sort -m10G -T /tmp/aln.sorted -o $LIPEO.sorted.bam $LIPEO.bam

