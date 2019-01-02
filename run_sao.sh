#!/bin/bash
output_sao="sao.csv"
echo "FILE,SAO,TestSAODisableAtPictureLevel,SaoEncodingRate,SAO,MaxNumOffsetsPerPic,SAOLcuBoundary">$output_sao
array=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z AB AC AD AE AF AG AH AI AJ AK AL)
jarray=(ai ra)
#sequence=(FlyingGraphics Programming  WordEditing)
i=0
f=30
dir=sao
mkdir ${dir}
for TestSAODisableAtPictureLevel in 0 1
do
	for SaoEncodingRate in -1  0.75
	do 
		for SAO in 0 1
		do 
			for SAOLcuBoundary in 0 1
			do 								
				echo "ALI_SAO_${array[$i]},$SaoLumaOffsetBitShift,$SaoChromaOffsetBitShift,$SAO,$TestSAODisableAtPictureLevel,$SaoEncodingRate,$SAO,$MaxNumOffsetsPerPic,$SAOLcuBoundary,$SAOResetEncoderStateAfterIRAP">>$output_sliceSegment
				for s in FlyingGraphics Programing  WordEditing
				do
					j=0
					#encoder_randomaccess_main_scc encoder_lowdelay_main_scc encoder_lowdelayp_main_scc
					for cfg in encoder_intra_main_scc
					do	
						./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f  --TestSAODisableAtPictureLevel=$TestSAODisableAtPictureLevel --SaoEncodingRate=$SaoEncodingRate --SAO=$SAO  --SAOLcuBoundary=$SAOLcuBoundary --IntraBlockCopyEnabled=0 --PaletteMode=0 -b ${dir}/ALI_SAO_${jarray[$j]}_${s}_${array[$i]}_0.bin
						./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f  --TestSAODisableAtPictureLevel=$TestSAODisableAtPictureLevel --SaoEncodingRate=$SaoEncodingRate --SAO=$SAO  --SAOLcuBoundary=$SAOLcuBoundary --IntraBlockCopyEnabled=1 --PaletteMode=0 -b ${dir}/ALI_SAO_${jarray[$j]}_${s}_${array[$i]}_1.bin
						./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f  --TestSAODisableAtPictureLevel=$TestSAODisableAtPictureLevel --SaoEncodingRate=$SaoEncodingRate --SAO=$SAO  --SAOLcuBoundary=$SAOLcuBoundary --IntraBlockCopyEnabled=0 --PaletteMode=1 -b ${dir}/ALI_SAO_${jarray[$j]}_${s}_${array[$i]}_2.bin
						./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f  --TestSAODisableAtPictureLevel=$TestSAODisableAtPictureLevel --SaoEncodingRate=$SaoEncodingRate --SAO=$SAO  --SAOLcuBoundary=$SAOLcuBoundary --IntraBlockCopyEnabled=1 --PaletteMode=1 -b ${dir}/ALI_SAO_${jarray[$j]}_${s}_${array[$i]}_3.bin
						j=`expr $j+1`
					done
						i=`expr $i+1`
				done												
			done
			
		done 
	done
done
				