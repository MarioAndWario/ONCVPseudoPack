#!/bin/bash
# This script extract the input for ONCVPSP from SG15 PP library (v1.2)
# http://www.quantum-simulation.org/potentials/sg15_oncv/
# and use ONCVPSP v3.3.1 + libxc v3.0.1 to produce ONCVPSP PBE pseudopotentials (SR+FR)
# and store the pseudopotentials in /global/homes/m/mwu/PP/ONCVPSP/Abinit_PP/PBE

INPUT_DIR="../INPUT"
OUTPUT_DIR="../PBE"
functional="PBE"
surfix="SG15v1.2"
echo "Generating PP with ${functional} functional..."
for file in ${INPUT_DIR}/*1.2.upf
do
    filename=$(basename "$file")
    prefix=$(echo ${filename} | awk -F"_O" '{print $1}')
    # echo $file $filename $extension $prefix
    echo "================================================"
    echo $prefix
    line_start=$(grep -a --text -n '# ATOM AND REFERENCE CONFIGURATION' $file | awk -F ":" '{print $1}')
    line_end=$(grep -a --text -n '# nvcnf' $file | awk -F ":" '{print $1+1}')
    # echo $line_start $line_end
    sed -n "$line_start, $line_end p" $file | sed 's/psp8/upf/g' > "./${prefix}.dat"
    ./run.sh ${prefix} -np
    ./extract.sh "${prefix}"
    ./run_r.sh ${prefix} -np
    ./extract.sh "${prefix}_r"

    mv ${prefix}.oncvpsp.upf ${OUTPUT_DIR}/"${prefix}_${functional}_SR.${surfix}.UPF"
    mv ${prefix}_r.oncvpsp.upf ${OUTPUT_DIR}/"${prefix}_${functional}_FR.${surfix}.UPF"
    echo "================================================"
done
echo "Done"

