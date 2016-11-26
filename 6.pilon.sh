#/bin/csh
export DIRECT=./quiver91x_low_default
export GENOME=$DIRECT/quiver91x_low_default.fasta
export FRAGS=$DIRECT/vu_all.sorted.bam
export JUMPS=$DIRECT/LIPE_2_quiver91x_low_default.sorted.bam

~/bin/samtools index $FRAGS
~/bin/samtools index $JUMPS
java -Xmx128G -jar ~/bin/pilon-1.18.jar --fix bases --genome $GENOME --frags $FRAGS --jumps $JUMPS --threads 16 --tracks > pilon.log.txt
