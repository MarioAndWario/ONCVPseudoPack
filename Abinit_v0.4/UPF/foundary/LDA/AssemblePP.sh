#!/bin/bash
# This script extract the input for ONCVPSP from Abinit PP library (v0.4)
# https://www.abinit.org/downloads/pseudodojo/pseudodojo
# and use ONCVPSP v3.3.1 + libxc v3.0.1 to produce ONCVPSP LDA pseudopotentials (SR+FR)
# and store the pseudopotentials in ${OUTPUT_DIR}

INPUT_DIR="../../../INPUT"
OUTPUT_DIR="../../LDA"
functional="LDA"
mkdir -p ${OUTPUT_DIR}
echo "Generating PP with ${functional} functional..."
surfix="ABIv0.4"
for file in ${INPUT_DIR}/*
do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    prefix="${filename%.*}"
    #echo $file $filename $extension $prefix
    echo "================================================"
    echo $prefix
    line_start=$(grep -a --text -n '# ATOM AND REFERENCE CONFIGURATION' $file | awk -F ":" '{print $1}')
    line_end=$(grep -a --text -n '# nvcnf' $file | awk -F ":" '{print $1+2}')
    # echo $line_start $line_end
    sed -n "$line_start, $line_end p" $file | sed 's/4      psp8/3      upf/g' > "./${prefix}.dat"
    ./run.sh ${prefix} -np
    ./extract.sh "${prefix}"
    ./run_r.sh ${prefix} -np
    ./extract.sh "${prefix}_r"

    mv ${prefix}.oncvpsp.upf ${OUTPUT_DIR}/"${prefix}_${functional}_SR.${surfix}.UPF"
    mv ${prefix}_r.oncvpsp.upf ${OUTPUT_DIR}/"${prefix}_${functional}_FR.${surfix}.UPF"

    rm -rf ${prefix}*.out
    rm -rf ${prefix}*.dat
    echo "================================================"
done
echo "Done"

