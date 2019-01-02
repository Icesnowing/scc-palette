#!/bin/bash

output_ratecontrol="ratecontrol.csv"
echo "FILE,LCULevelRateControl,TargetBitrate" > $output_ratecontrol
array=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
jarray=(ai ra)
#sequence=(Desktop Robot WebBrowsing )
i=0
f=30
dir=ratecontrol
mkdir ${dir}
for LCULevelRateControl in 0 1
do
	for TargetBitrate in 50000 500000 1000000 5000000 10000000 20000000
	do
		echo "ALI_ratecontrol_${array[$i]} , $LCULevelRateControl ,  $TargetBitrate"  >> $output_ratecontrol
		for s in Desktop Robot WebBrowsing
		do
			j=0
			for cfg in encoder_intra_main_scc
			do
				./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --RateControl=1 --LCULevelRateControl=$LCULevelRateControl --TargetBitrate=$TargetBitrate --IntraBlockCopyEnabled=0 --PaletteMode=0 -b ${dir}/ALI_ratecontrol_${jarray[$j]}_${s}_${array[$i]}_0.bin
				./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --RateControl=1 --LCULevelRateControl=$LCULevelRateControl --TargetBitrate=$TargetBitrate --IntraBlockCopyEnabled=1 --PaletteMode=0 -b ${dir}/ALI_ratecontrol_${jarray[$j]}_${s}_${array[$i]}_1.bin
				./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --RateControl=1 --LCULevelRateControl=$LCULevelRateControl --TargetBitrate=$TargetBitrate --IntraBlockCopyEnabled=0 --PaletteMode=1 -b ${dir}/ALI_ratecontrol_${jarray[$j]}_${s}_${array[$i]}_2.bin
				./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --RateControl=1 --LCULevelRateControl=$LCULevelRateControl --TargetBitrate=$TargetBitrate --IntraBlockCopyEnabled=1 --PaletteMode=1 -b ${dir}/ALI_ratecontrol_${jarray[$j]}_${s}_${array[$i]}_3.bin
			j=`expr $j + 1`
			done
		done
		i=`expr $i + 1`
	done
done


#./TAppEncoder -c encoder_randomaccess_main_scc.cfg -c SlideShow_444.cfg --Log2ParallelratecontrolLevel= -b ALI_ratecontrol_G.bin