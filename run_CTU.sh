#!/bin/bash

output_ctu="ctu.csv"
echo "FILE, MaxCTUWidth, MaxCUSize, MaxPartitionDepth" > $output_ctu
array=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z AA AB AC AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB BC BD BE BF BG BH BI BJ BK BL BM BN BO BP BQ BR BS BT BU BV BW BX BY BZ)
jarray=(ai ra)
#sequence=(FlyingGraphics WebBrowsing WordEditing)
i=0
f=30
dir=ctu
mkdir ${dir}
for ctu in 64 32 16
do
    for cu in 8 16 32
    do
        for depth in 1 2 3 4
        do
                echo "ALI_CTU_${array[$i]} , $ctu , $cu , $depth"  >> $output_ctu
                for s in FlyingGraphics WebBrowsing WordEditing
                do
                    j=0
                    #encoder_randomaccess_main_scc encoder_lowdelay_main_scc encoder_lowdelayp_main_scc
                    for cfg in encoder_intra_main_scc
                    do
                        ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --MaxCUWidth=$ctu --MaxCUHeight=$ctu --MaxCUSize=$cu --MaxPartitionDepth=$depth --IntraBlockCopyEnabled=0 --PaletteMode=0 -b ${dir}/ALI_CTU_${jarray[$j]}_${s}_${array[$i]}_0.bin
                        ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --MaxCUWidth=$ctu --MaxCUHeight=$ctu --MaxCUSize=$cu --MaxPartitionDepth=$depth --IntraBlockCopyEnabled=1 --PaletteMode=0 -b ${dir}/ALI_CTU_${jarray[$j]}_${s}_${array[$i]}_1.bin
                        ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --MaxCUWidth=$ctu --MaxCUHeight=$ctu --MaxCUSize=$cu --MaxPartitionDepth=$depth --IntraBlockCopyEnabled=0 --PaletteMode=1 -b ${dir}/ALI_CTU_${jarray[$j]}_${s}_${array[$i]}_2.bin
                        ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --MaxCUWidth=$ctu --MaxCUHeight=$ctu --MaxCUSize=$cu --MaxPartitionDepth=$depth --IntraBlockCopyEnabled=1 --PaletteMode=1 -b ${dir}/ALI_CTU_${jarray[$j]}_${s}_${array[$i]}_3.bin

                        j=`expr $j + 1`
                    done
                done
                i=`expr $i + 1`
        done
    done
done

#./TAppEncoder -c encoder_randomaccess_main_scc.cfg -c SlideShow_444.cfg --Log2ParallelMergeLevel= -b ALI_MERGE_G.bin