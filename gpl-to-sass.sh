#!/bin/bash

# input arguments
#input_gpl_file=$1
#output_sass_file=$2

input_gpl_file='/home/valentin/Yandex.Disk/GEF/GEF Vision/Layouts for customers/Viipurin Golf/palette.gpl'

input_folder=$(dirname "${input_gpl_file}")
input_filename=$(basename "${input_gpl_file}")

# Forming temp and sass filename
input_name=${input_filename%.*}
input_ext=${input_filename##*.}
temp_filename=$input_name'_tmp'.$input_ext
sass_filename=$input_name.'scss'

# === CONVERSION ROUTINE ===

# Removing header. Writing output to temp file
tail -n +5 "$input_gpl_file" > "$input_folder/$temp_filename"

# Read temp file into array
readarray color_data_array < "$input_folder/$temp_filename"

# Initializing SCSS file
echo -n '' > "$input_folder/$sass_filename"

for ((i=0; i < ${#color_data_array[@]}; i+=1))
do
    read -a color <<< ${color_data_array[i]}

    hex_red=$(printf '%x\n' ${color[0]})
    hex_green=$(printf '%x\n' ${color[1]})
    hex_blue=$(printf '%x\n' ${color[2]})

    col=''

    for ((j=3; j < ${#color[@]}; j+=1))
    do
        if [ $j == 3 ]; then
            col=${color[$j]}
        else
            col=$col'_'${color[$j]}
        fi
    done

    scss_var_name=$(echo '$'$col | awk '{print toupper($0)}')

    hex='#'$hex_red$hex_green$hex_blue

    echo $scss_var_name': '$hex';' >> "$input_folder/$sass_filename"
done

rm "$input_folder/$temp_filename"