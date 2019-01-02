#!/bin/bash

output_deblcok="deblock.csv"
echo "FILE,QP ,LoopFilterBetaOffset, LoopFilterTcOffset, LoopFilterOffsetInPPS,DeblockingFilterMetric" > $output_deblock
array=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z AA AB AC AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB BC BD BE BF BG BH BI BJ BK BL BM BN BO BP BQ BR BS BT BU BV BW BX BY BZ CA CB CC CD CE CF CG CH CI CJ CK CL CM CN CO CP CQ CR CS CT CU CV CW CX CY CZ DA DB DC DD DE DF DG DH DI DJ DK DL DM DN DO DP DQ DR DS DT DU DV DW DX DY DZ EA EB EC ED EE EF EG EH EI EJ EK EL EM EN EO EP EQ ER ES ET EU EV EW EX EY EZ)
jarray=(ai ra)
#sequence=(Console WebBrowsing WordEditing)
i=0
f=30
dir=deblock
mkdir ${dir}
for BetaOffset in {-1..2}
do
    for TcOffset in {-1..2}
    do
        for OffsetInPPS in 0 1
        do
		for Qp in 22 27 32 37
		do
			DeblockingFilterMetric=1-$OffsetInPPS
		        echo "ALI_DEBLOCK_${array[$i]} , $Qp , $BetaOffset , $TcOffset , $OffsetInPPS , $DeblockingFilterMetric"  >> $output_deblock
		        for s in Console WebBrowsing WordEditing
		        do
		            j=0
		            #encoder_randomaccess_main_scc encoder_lowdelay_main_scc encoder_lowdelayp_main_scc
		            for cfg in encoder_intra_main_scc
		            do
		                ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --QP=$Qp --LoopFilterBetaOffset_div2=$BetaOffset --LoopFilterTcOffset_div2=$TcOffset --LoopFilterOffsetInPPS=$OffsetInPPS --DeblockingFilterMetric=$DeblockingFilterMetric --IntraBlockCopyEnabled=0 --PaletteMode=0 -b ${dir}/ALI_DEBLOCK_${jarray[$j]}_${s}_${array[$i]}_0.bin
		                ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --QP=$Qp --LoopFilterBetaOffset_div2=$BetaOffset --LoopFilterTcOffset_div2=$TcOffset --LoopFilterOffsetInPPS=$OffsetInPPS --DeblockingFilterMetric=$DeblockingFilterMetric --IntraBlockCopyEnabled=1 --PaletteMode=0 -b ${dir}/ALI_DEBLOCK_${jarray[$j]}_${s}_${array[$i]}_1.bin
		                ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --QP=$Qp --LoopFilterBetaOffset_div2=$BetaOffset --LoopFilterTcOffset_div2=$TcOffset --LoopFilterOffsetInPPS=$OffsetInPPS --DeblockingFilterMetric=$DeblockingFilterMetric --IntraBlockCopyEnabled=0 --PaletteMode=1 -b ${dir}/ALI_DEBLOCK_${jarray[$j]}_${s}_${array[$i]}_2.bin
		                ./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --QP=$Qp --LoopFilterBetaOffset_div2=$BetaOffset --LoopFilterTcOffset_div2=$TcOffset --LoopFilterOffsetInPPS=$OffsetInPPS --DeblockingFilterMetric=$DeblockingFilterMetric --IntraBlockCopyEnabled=1 --PaletteMode=1 -b ${dir}/ALI_DEBLOCK_${jarray[$j]}_${s}_${array[$i]}_3.bin

		                j=`expr $j + 1`
		            done
		        done
		        i=`expr $i + 1`
		done
        done
    done
done

#./TAppEncoder -c encoder_randomaccess_main_scc.cfg -c SlideShow_444.cfg --Log2ParallelMergeLevel= -b ALI_MERGE_G.bin