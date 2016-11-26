#/bin/csh
/home/stelo/MUMmer3.23/nucmer --prefix=pilon_2_PV ~/Pvulgaris/Pvulgaris_218_v1.0_chr.fa ./pilonquiver57x_fast_erate0.025_v1.2/pilonquiver57x.fasta
/home/stelo/MUMmer3.23/nucmer --prefix=pilonscaffolds_2_PV ~/Pvulgaris/Pvulgaris_218_v1.0_chr.fa ~/releases/pilonquiver57x_fast.super_scaffold.fasta
#show-coords -rcl ref_qry.delta > ref_qry.coords
#show-aligns ref_qry.delta refname qryname > ref_qry.aligns
#show-tiling ref_qry.delta > ref_qry.tiling
/home/stelo/MUMmer3.23/delta-filter -q pilon_2_PV.delta > pilon_2_PV.filter
/home/stelo/MUMmer3.23/mummerplot --filter --fat -prefix=pilon_2_PV -png pilon_2_PV.delta
/home/stelo/MUMmer3.23/mummerplot --coverage -prefix=pilon_2_PV -png pilon_2_PV.delta
