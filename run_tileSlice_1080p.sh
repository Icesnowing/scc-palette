#!/bin/bash

output_tileslice_1080p="tileslice_1080p.csv"
echo "FILE;TileUniformSpacing;NumTileColumnsMinus1;NumTileRowsMinus1;SliceMode;SliceArgument" > $output_tileslice_1080p
array=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z AA AB AC AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB BC BD BE BF BG BH BI BJ BK BL BM BN BO BP BQ BR BS BT BU BV BW BX BY BZ CA CB CC CD CE CF CG CH CI CJ CK CL CM CN CO CP CQ CR CS CT CU CV CW CX CY CZ DA DB DC DD DE DF DG DH DI DJ DK DL DM DN DO DP DQ DR DS DT DU DV DW DX DY DZ)
jarray=(ai ra)
#sequence=(SlideShow FlyingGraphics  Robot )

i=0
f=30
dir=tileslice_1080p
mkdir ${dir}
#slice include tile
for SliceArgument in 2 3 4
do
	for NumTileColumnsMinus1 in 1 2 3
	do
		for NumTileRowsMinus1 in 1 2 3
		do 
			echo "ALI_TILE_${array[$i]} ; 1 ; $NumTileColumnsMinus1 ; $NumTileRowsMinus1 ; 3 ;$SliceArgument"  >> $output_tileslice_1080p
			for s in SlideShow FlyingGraphics  Robot
			do
				j=0
				#encoder_randomaccess_main_scc encoder_lowdelay_main_scc encoder_lowdelayp_main_scc
				for cfg in encoder_intra_main_scc
				do
					./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceArgument=$SliceArgument --SliceMode=3 --TileUniformSpacing=1 --NumTileColumnsMinus1=$NumTileColumnsMinus1 --NumTileRowsMinus1=$NumTileRowsMinus1 --IntraBlockCopyEnabled=0 --PaletteMode=0 -b ${dir}/ALI_TILE_${jarray[$j]}_${s}_${array[$i]}_0.bin
					./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceArgument=$SliceArgument --SliceMode=3 --TileUniformSpacing=1 --NumTileColumnsMinus1=$NumTileColumnsMinus1 --NumTileRowsMinus1=$NumTileRowsMinus1 --IntraBlockCopyEnabled=1 --PaletteMode=0 -b ${dir}/ALI_TILE_${jarray[$j]}_${s}_${array[$i]}_1.bin
					./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceArgument=$SliceArgument --SliceMode=3 --TileUniformSpacing=1 --NumTileColumnsMinus1=$NumTileColumnsMinus1 --NumTileRowsMinus1=$NumTileRowsMinus1 --IntraBlockCopyEnabled=0 --PaletteMode=1 -b ${dir}/ALI_TILE_${jarray[$j]}_${s}_${array[$i]}_2.bin
					./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceArgument=$SliceArgument --SliceMode=3 --TileUniformSpacing=1 --NumTileColumnsMinus1=$NumTileColumnsMinus1 --NumTileRowsMinus1=$NumTileRowsMinus1 --IntraBlockCopyEnabled=1 --PaletteMode=1 -b ${dir}/ALI_TILE_${jarray[$j]}_${s}_${array[$i]}_3.bin
					j=`expr $j + 1`
				done
			done
			i=`expr $i + 1`
		done
	done
done
#tile include slice 
for SliceArgument in 3 5 15
do
	for NumTileColumnsMinus1 in 0 1
	do
		for NumTileRowsMinus1 in 0 1
		do 
			echo "ALI_TILE_${array[$i]} ; 1 ; $NumTileColumnsMinus1 ; $NumTileRowsMinus1 ; 1 ;$SliceArgument"  >> $output_tileslice_1080p
			for s in SlideShow FlyingGraphics  Robot
			do
				j=0
				#encoder_randomaccess_main_scc encoder_lowdelay_main_scc encoder_lowdelayp_main_scc
				for cfg in encoder_intra_main_scc
				do
					./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceArgument=$SliceArgument --SliceMode=1 --TileUniformSpacing=1 --NumTileColumnsMinus1=$NumTileColumnsMinus1 --NumTileRowsMinus1=$NumTileRowsMinus1 --IntraBlockCopyEnabled=0 --PaletteMode=0 -b ${dir}/ALI_TILE_${jarray[$j]}_${s}_${array[$i]}_0.bin
					./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceArgument=$SliceArgument --SliceMode=1 --TileUniformSpacing=1 --NumTileColumnsMinus1=$NumTileColumnsMinus1 --NumTileRowsMinus1=$NumTileRowsMinus1 --IntraBlockCopyEnabled=1 --PaletteMode=0 -b ${dir}/ALI_TILE_${jarray[$j]}_${s}_${array[$i]}_1.bin
					./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceArgument=$SliceArgument --SliceMode=1 --TileUniformSpacing=1 --NumTileColumnsMinus1=$NumTileColumnsMinus1 --NumTileRowsMinus1=$NumTileRowsMinus1 --IntraBlockCopyEnabled=0 --PaletteMode=1 -b ${dir}/ALI_TILE_${jarray[$j]}_${s}_${array[$i]}_2.bin
					./TAppEncoderStatic -c $cfg.cfg -c persequence/${s}_444.cfg --FramesToBeEncoded=$f --SliceArgument=$SliceArgument --SliceMode=1 --TileUniformSpacing=1 --NumTileColumnsMinus1=$NumTileColumnsMinus1 --NumTileRowsMinus1=$NumTileRowsMinus1 --IntraBlockCopyEnabled=1 --PaletteMode=1 -b ${dir}/ALI_TILE_${jarray[$j]}_${s}_${array[$i]}_3.bin
					j=`expr $j + 1`
				done
			done
			i=`expr $i + 1`
		done
	done
done