#! /bin/sh

echo "Enter the wanted directory to apply script on."
read directory
lscommand="$(ls "$directory")"
filesarr=($lscommand)

if [ ! -d "$directory" ]
then 
    echo "no such directory"
    exit 1
fi

for filename in ${filesarr[*]}
do
    filename="$directory/$filename"
    # echo $filename
    if [ -f $filename ]
    then
        case ${filename##*/} in
        ?*.?*)
            extension="${filename##*.}"
            if [ -e "$directory/$extension" ]
            then
                mv $filename "$directory/$extension"
                echo "$filename is moved to $directory/$extension"
            else
                mkdir "$directory/$extension"
                mv $filename "$directory/$extension"
                echo "$filename is moved to $directory/$extension"
            fi
            ;;
        *)
            if [ -e "$directory/unknown" ]
            then
                mv $filename "$directory/unknown"
                echo "$filename is moved to $directory/unknown"
            else
                mkdir "$directory/unknown"
                mv $filename "$directory/unknown"
                echo "$filename is moved to $directory/unknown"
            fi
            ;;
        esac
    fi
done

