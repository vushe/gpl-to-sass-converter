#!/bin/bash

input_gpl_file="$1"

# If there is no arguments passed of file is missing, exit with warning
if [ ! -e "$input_gpl_file" ]; then
    echo ''
    echo '=========================================================='
    echo 'Warning! Please pass GPL file to process. Does file exist?'
    echo 'Exiting without actions.'
    echo '=========================================================='
    echo ''
    exit 1
fi

dec_to_hex() {

    if [ $1 -gt 16 ]; then
        printf "%x" $1
    # Providing leading zeroes for numbers lower than 16
    else
        printf "0%x" $1
    fi
}

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

processed_colors=()

# Initializing SCSS file
echo -n '' > "$input_folder/$sass_filename"

for ((i=0; i < ${#color_data_array[@]}; i+=1))
do
    read -a color <<< ${color_data_array[$i]}

    hex_red=$(dec_to_hex ${color[0]})
    hex_green=$(dec_to_hex ${color[1]})
    hex_blue=$(dec_to_hex ${color[2]})

    col=''

    for ((j=3; j < ${#color[@]}; j+=1))
    do
        if [ $j == 3 ]; then
            col=${color[$j]}

        # If color is named with more than two words...
        else
            col=$col'_'${color[$j]}
        fi
    done

    col_repeats_num=`printf '%s\n' "${processed_colors[@]}" | grep "$col" | wc -w`

    if [ $col_repeats_num -ge 1 ]; then
        col=$col'_'$col_repeats_num
    fi

    processed_colors[$i]=$col

    # Convert color name to upper case
    scss_var_name=$(echo '$'$col | awk '{print toupper($0)}')

    hex='#'$hex_red$hex_green$hex_blue

    echo $scss_var_name': '$hex';' >> "$input_folder/$sass_filename"
done

rm "$input_folder/$temp_filename"

exit 0