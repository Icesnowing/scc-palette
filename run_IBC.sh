#!/bin/bash

output_IBC="IBC.csv"
echo "FILE,DEBLOCKDISABLE,SAO" > $output_IBC
array=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
jarray=(ai ra)
#sequence=(SlideShow Console Map )
i=0
f=30
dir=IBC
mkdir ${dir}
echo "ALI_IBC_${array[$i]} , 1 , 0 "  >> $output_IBC
for s in SlideShow Console Map 
do
    j=0
        #encoder_randomaccess_main_scc encoder_lowdelay_main_scc encoder_lowdelayp_main_scc
        for cfg in encoder_intra_main_scc
        do
            ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SAO=0 --LoopFilterDisable=1 --IntraBlockCopyEnabled=0 --PaletteMode=0 -b ${dir}/ALI_IBC_${jarray[$j]}_${s}_${array[$i]}_0.bin
            ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SAO=0 --LoopFilterDisable=1 --IntraBlockCopyEnabled=1 --PaletteMode=0 -b ${dir}/ALI_IBC_${jarray[$j]}_${s}_${array[$i]}_1.bin
            ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SAO=0 --LoopFilterDisable=1 --IntraBlockCopyEnabled=0 --PaletteMode=1 -b ${dir}/ALI_IBC_${jarray[$j]}_${s}_${array[$i]}_2.bin
            ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SAO=0 --LoopFilterDisable=1 --IntraBlockCopyEnabled=1 --PaletteMode=1 -b ${dir}/ALI_IBC_${jarray[$j]}_${s}_${array[$i]}_3.bin
        j=`expr $j + 1`
        done
done
i=`expr $i + 1`


#./TAppEncoder -c encoder_randomaccess_main_scc.cfg -c SlideShow_444.cfg --Log2ParallelMergeLevel= -b ALI_MERGE_G.bin