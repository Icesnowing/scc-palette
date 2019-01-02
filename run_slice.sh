#!/bin/bash

output_slice="slice.csv"
echo "FILE,SliceMode,SliceArgument,LFCrossSliceBoundaryFlag" > $output_slice
array=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
jarray=(ai ra )
#sequence=(SlideShow Desktop Robot )
SliceArgument=(0 30 1500 4)
i=0
sa=0
f=30
dir=slice
mkdir ${dir}
for SliceMode in 0 1 2 3
do
	for LFCrossSliceBoundaryFlag in 0 1
	do
		echo "ALI_SLICE_${array[$i]} , $SliceMode , ${SliceArgument[$sa]} , $LFCrossSliceBoundaryFlag"  >> $output_slice
		for s in SlideShow Desktop Robot 
		do
			j=0
                    	#encoder_randomaccess_main_scc encoder_lowdelay_main_scc encoder_lowdelayp_main_scc
                    	for cfg in encoder_intra_main_scc
                    	do
				./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceMode=$SliceMode --SliceArgument=${SliceArgument[$sa]} --LFCrossSliceBoundaryFlag=$LFCrossSliceBoundaryFlag --IntraBlockCopyEnabled=0 --PaletteMode=0 -b ${dir}/ALI_SLICE_${jarray[$j]}_${s}_${array[$i]}_0.bin
				./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceMode=$SliceMode --SliceArgument=${SliceArgument[$sa]} --LFCrossSliceBoundaryFlag=$LFCrossSliceBoundaryFlag --IntraBlockCopyEnabled=1 --PaletteMode=0 -b ${dir}/ALI_SLICE_${jarray[$j]}_${s}_${array[$i]}_1.bin
				./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceMode=$SliceMode --SliceArgument=${SliceArgument[$sa]} --LFCrossSliceBoundaryFlag=$LFCrossSliceBoundaryFlag --IntraBlockCopyEnabled=0 --PaletteMode=1 -b ${dir}/ALI_SLICE_${jarray[$j]}_${s}_${array[$i]}_2.bin
				./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceMode=$SliceMode --SliceArgument=${SliceArgument[$sa]} --LFCrossSliceBoundaryFlag=$LFCrossSliceBoundaryFlag --IntraBlockCopyEnabled=1 --PaletteMode=1 -b ${dir}/ALI_SLICE_${jarray[$j]}_${s}_${array[$i]}_3.bin
			j=`expr $j + 1`
			done
		done
		i=`expr $i + 1`
	done
	sa=`expr $sa + 1`
done


#./TAppEncoder -c encoder_randomaccess_main_scc.cfg -c SlideShow_444.cfg --Log2ParallelMergeLevel= -b ALI_MERGE_G.bin