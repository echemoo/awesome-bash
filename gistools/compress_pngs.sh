#! /bin/bash
function getdir(){
    for element in `ls $1`
    do  
        dir_or_file=$1"/"$element
        if [ -d $dir_or_file ]
        then 
            getdir $dir_or_file
        else
            #echo $dir_or_file
            #wc -c < $dir_or_file
            if [ `wc -c < $dir_or_file` -eq 334 ]
            then
                echo $dir_or_file
                #rm $dir_or_file
            else
                #pngquant $dir_or_file -o $dir_or_file -f
                /Users/apple/myDir/github/zopfli/zopflipng -y $dir_or_file $dir_or_file &> /dev/null
            fi
        fi  
    done
}
# root_dir="/home/test"
root_dir=`pwd`
getdir $root_dir

