#!/bin/bash

output_pmerge="pmerge.csv"
echo "FILE,Log2ParallelMergeLevel" > $output_pmerge
array=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
jarray=(ai ra)
#sequence=(SlideShow Console Programming)
i=0
f=30
dir=pmerge
mkdir ${dir}
for Log2ParallelMergeLevel in 2 3 4 5 6
do
		echo "ALI_PMERGE_${array[$i]} , $Log2ParallelMergeLevel "  >> $output_pmerge
		for s in SlideShow Console Programming 
		do
			j=0
                    	#encoder_randomaccess_main_scc encoder_lowdelay_main_scc encoder_lowdelayp_main_scc
                    	for cfg in encoder_intra_main_scc
                    	do
				./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --Log2ParallelMergeLevel=$Log2ParallelMergeLevel --IntraBlockCopyEnabled=0 --PaletteMode=0 -b ${dir}/ALI_PMERGE_${jarray[$j]}_${s}_${array[$i]}_0.bin
				./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --Log2ParallelMergeLevel=$Log2ParallelMergeLevel --IntraBlockCopyEnabled=1 --PaletteMode=0 -b ${dir}/ALI_PMERGE_${jarray[$j]}_${s}_${array[$i]}_1.bin
				./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --Log2ParallelMergeLevel=$Log2ParallelMergeLevel --IntraBlockCopyEnabled=0 --PaletteMode=1 -b ${dir}/ALI_PMERGE_${jarray[$j]}_${s}_${array[$i]}_2.bin
				./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --Log2ParallelMergeLevel=$Log2ParallelMergeLevel --IntraBlockCopyEnabled=1 --PaletteMode=1 -b ${dir}/ALI_PMERGE_${jarray[$j]}_${s}_${array[$i]}_3.bin
			j=`expr $j + 1`
			done
		done
		i=`expr $i + 1`
done


#./TAppEncoder -c encoder_randomaccess_main_scc.cfg -c SlideShow_444.cfg --Log2ParallelMergeLevel= -b ALI_MERGE_G.bin