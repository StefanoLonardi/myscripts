#/bin/csh
/24-2/home/stelo/canu/Linux-amd64/bin/canu corMhapSensitivity=high corOutCoverage=100 -p cowpea -d cowpea genomeSize=620m -pacbio-raw /24-2/home/stelo/pacbio_cowpea_fasta_merged/allsubreads.fasta

/24-2/home/stelo/canu/Linux-amd64/bin/canu -correct corMhapSensitivity=normal corMaxEvidenceErate=0.15 corOutCoverage=100 -d cowpea_repeat -p cowpea genomeSize=620m -pacbio-raw unmappedSubreads_quiver_canu91x_low_default.fasta
/24-2/home/stelo/canu/Linux-amd64/bin/canu -trim -d cowpea_repeat -p cowpea genomeSize=620m -pacbio-corrected ./cowpea_repeat/cowpea.correctedReads.fasta.gz
/24-2/home/stelo/canu/Linux-amd64/bin/canu -assemble ovlMerSize=31 -d cowpea_repeat -p cowpea genomeSize=620m -pacbio-corrected ./cowpea_repeat/cowpea.trimmedReads.

#As for assembling the unassembled reads:
# *  Use the previously corrected reads (-trim-assemble).
# *  Increase kmer size, up to 31 (ovlMerSize).
# *  Increase kmer cutoff threshold (ovlMerThreshold, ovlMerDistinct, ovlMerTotal) to ...?
#Generating the kmer histogram for each mersize 22..31 (maybe 22, 25, 28, 31) will help picking both parameters.
#You'll want to pick the largest mer size that doesn't have a bunch of unique (count=1) kmers. For the
#threshold, a good starting guess would be ovlMerDistinct=0.99 -- ignore the most common 1% of kmers when
#seeding overlaps. I (still) haven't written up the method I use for picking this. The gist is to plot column 3
#(fraction distinct) vs 4 (fraction actual) in the meryl histogram output, then finding a knee where fraction
#actual dominates.

# OLD
/24-2/home/stelo/canu/Linux-amd64/bin/canu -correct -p cowpea corMhapSensitivity=high corMinCoverage=2 -d cowpea genomeSize=620m -pacbio-raw ../pacbio_cowpea/*.fastq
/24-2/home/stelo/canu/Linux-amd64/bin/canu -trim -p cowpea -d cowpea genomeSize=620m -pacbio-corrected ./cowpea/cowpea.correctedReads.fasta.gz
/24-2/home/stelo/canu/Linux-amd64/bin/canu -assemble -p cowpea -d cowpea-erate-0.025 errorRate=0.025 genomeSize=620m -pacbio-corrected ./cowpea/cowpea.trimmedReads.fastq
