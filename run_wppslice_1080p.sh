#!/bin/bash

output_wppslice_1080p="wppslice_1080p.csv"
echo "FILE;WaveFrontSynchro;SliceArgument;SliceMode" > $output_wppslice_1080p
array=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z AA AB AC AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB BC BD BE BF BG BH BI BJ BK BL BM BN BO BP BQ BR BS BT BU BV BW BX BY BZ CA CB CC CD CE CF CG CH CI CJ CK CL CM CN CO CP CQ CR CS CT CU CV CW CX CY CZ DA DB DC DD DE DF DG DH DI DJ DK DL DM DN DO DP DQ DR DS DT DU DV DW DX DY DZ)
jarray=(ai ra )
#sequence=(Desktop Map Robot )

i=0
f=30
dir=wppslice_1080p
mkdir ${dir}

for SliceArgument in 60 90
do
	for WaveFrontSynchro in 0 1
	do 
   		echo "ALI_WAVEFRONT_${array[$i]},$WaveFrontSynchro,$SliceArgument,1">>$output_wppslice_1080p
   		for s in Desktop Map Robot 
	   	do
	      		j=0
		  	for cfg in encoder_intra_main_scc
		  	do
		     	./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --WaveFrontSynchro=$WaveFrontSynchro --SliceArgument=$SliceArgument --SliceMode=1 --IntraBlockCopyEnabled=0 --PaletteMode=0 -b ${dir}/ALI_WAVEFRONT_${jarray[$j]}_${s}_${array[$i]}_0.bin
			 	./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --WaveFrontSynchro=$WaveFrontSynchro --SliceArgument=$SliceArgument --SliceMode=1 --IntraBlockCopyEnabled=1 --PaletteMode=0 -b ${dir}/ALI_WAVEFRONT_${jarray[$j]}_${s}_${array[$i]}_0.bin
			 	./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --WaveFrontSynchro=$WaveFrontSynchro --SliceArgument=$SliceArgument --SliceMode=1 --IntraBlockCopyEnabled=0 --PaletteMode=1 -b ${dir}/ALI_WAVEFRONT_${jarray[$j]}_${s}_${array[$i]}_0.bin
			 	./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --WaveFrontSynchro=$WaveFrontSynchro --SliceArgument=$SliceArgument --SliceMode=1 --IntraBlockCopyEnabled=1 --PaletteMode=1 -b ${dir}/ALI_WAVEFRONT_${jarray[$j]}_${s}_${array[$i]}_0.bin
		   		j=`expr $j+1`
	       		done
	    	done
	    	i=`expr $i+1`
	done
done