#!/bin/bash
output_sliceSegment="sliceSegment.csv"
echo "FILE,SliceMode,SliceArgument,SliceSegmentMode,SliceSegmentArgument,LFCrossSliceBoundaryFlag">$output_sliceSegment
array=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z AB AC AD AE AF AG)
jarray=(ai ra)
#sequence=( Desktop Programing Robot )
SliceArgument=(0 120 3000 4)
SliceSegmentArgument=(0 20 1000 2)
i=0
sa=0 
ssa=0
f=30
dir=sliceSegment
mkdir ${dir}
for SliceMode in 0 1 2 3
do
    sa=0
    for SliceSegmentMode in 0 1 2 3
    do
    ssa=0
        for LFCrossSliceBoundaryFlag in 0 1
	    do
	        echo "ALI_SLICESEGMENT_${array[$i]},$SliceMode,$SliceSegmentMode,${SliceArgument[$sa]},${SliceSegmentArgument[$ssa]},$LFCrossSliceBoundaryFlag">>$output_sliceSegment
		    for s in  Desktop Programing Robot 
		    do
		    j=0
		    #encoder_randomaccess_main_scc encoder_lowdelay_main_scc encoder_lowdelayp_main_scc
		    for cfg in encoder_intra_main_scc
		    do
                    ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceMode=$SliceMode --SliceSegmentMode=$SliceSegmentMode --SliceArgument=${SliceArgument[$sa]} --SliceSegmentArgument=${SliceSegmentArgument[$ssa]} --LFCrossSliceBoundaryFlag=$LFCrossSliceBoundaryFlag --IntraBlockCopyEnabled=0 --PaletteMode=0 -b ${dir}/ALI_SLICESEGMENT_${jarray[$j]}_${s}_${array[$i]}_0.bin
                    ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceMode=$SliceMode --SliceSegmentMode=$SliceSegmentMode --SliceArgument=${SliceArgument[$sa]} --SliceSegmentArgument=${SliceSegmentArgument[$ssa]} --LFCrossSliceBoundaryFlag=$LFCrossSliceBoundaryFlag --IntraBlockCopyEnabled=1 --PaletteMode=0 -b ${dir}/ALI_SLICESEGMENT_${jarray[$j]}_${s}_${array[$i]}_1.bin
                    ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceMode=$SliceMode --SliceSegmentMode=$SliceSegmentMode --SliceArgument=${SliceArgument[$sa]} --SliceSegmentArgument=${SliceSegmentArgument[$ssa]} --LFCrossSliceBoundaryFlag=$LFCrossSliceBoundaryFlag --IntraBlockCopyEnabled=0 --PaletteMode=1 -b ${dir}/ALI_SLICESEGMENT_${jarray[$j]}_${s}_${array[$i]}_2.bin
                    ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceMode=$SliceMode --SliceSegmentMode=$SliceSegmentMode --SliceArgument=${SliceArgument[$sa]} --SliceSegmentArgument=${SliceSegmentArgument[$ssa]} --LFCrossSliceBoundaryFlag=$LFCrossSliceBoundaryFlag --IntraBlockCopyEnabled=1 --PaletteMode=1 -b ${dir}/ALI_SLICESEGMENT_${jarray[$j]}_${s}_${array[$i]}_3.bin
		    j=`expr $j+1`
            done
        done
        i=`expr $i+1`
      done
      ssa=`expr $ssa+1`
   done
   sa=`expr $sa+1`
done   
