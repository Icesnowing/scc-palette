#!/bin/bash

output_palette="palette.csv"
echo "FILE,PaletteMaxSize,PaletteMaxPredSize" > $output_palette
array=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z )
jarray=(ai ra)
#sequence=(SlideShow flyingGraphics Map )
i=0
f=30
dir=palette
mkdir ${dir}

for PaletteMaxSize in 15 63 255
do
    for PaletteMaxPredSize in 128 256 
    do
        echo "ALI_palette_${array[$i]}  ,$PaletteMaxSize ,$PaletteMaxPredSize  "  >> $output_palette
        for s in SlideShow flyingGraphics Map 
        do
            j=0
                #encoder_randomaccess_main_scc encoder_lowdelay_main_scc encoder_lowdelayp_main_scc
                for cfg in encoder_intra_main_scc
                do
                    ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --PaletteMaxSize=$PaletteMaxSize --PaletteMaxPredSize=$PaletteMaxPredSize --IntraBlockCopyEnabled=0 --PaletteMode=0 -b ${dir}/ALI_palette_${jarray[$j]}_${s}_${array[$i]}_0.bin
                    ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --PaletteMaxSize=$PaletteMaxSize --PaletteMaxPredSize=$PaletteMaxPredSize --IntraBlockCopyEnabled=1 --PaletteMode=0 -b ${dir}/ALI_palette_${jarray[$j]}_${s}_${array[$i]}_1.bin
                    ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --PaletteMaxSize=$PaletteMaxSize --PaletteMaxPredSize=$PaletteMaxPredSize --IntraBlockCopyEnabled=0 --PaletteMode=1 -b ${dir}/ALI_palette_${jarray[$j]}_${s}_${array[$i]}_2.bin
                    ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --PaletteMaxSize=$PaletteMaxSize --PaletteMaxPredSize=$PaletteMaxPredSize --IntraBlockCopyEnabled=1 --PaletteMode=1 -b ${dir}/ALI_palette_${jarray[$j]}_${s}_${array[$i]}_3.bin
                j=`expr $j + 1`
                done
        done
        i=`expr $i + 1`
    done
done
          


#./TAppEncoder -c encoder_randomaccess_main_scc.cfg -c SlideShow_444.cfg --Log2ParallelMergeLevel= -b ALI_MERGE_G.bin