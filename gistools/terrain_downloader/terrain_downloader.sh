#!/bin/bash


rm -rf tmp
mkdir tmp
cd tmp

curl -s https://www.terrainserver.com/serveTerrain/world/layer.json -O

minZ=$2
maxZ=$1
if [[ -z $1  ]]; then
  maxZ=9
fi
if [[ -z $2  ]]; then
  minZ=0
fi
echo "minZ: $minZ    maxZ: $maxZ"

for (( z=minZ; z<=maxZ; z++)); do
  maxY=`bc <<< "2^$z-1"`
  maxX=`bc <<< "2^($z+1)-1"`
  #echo "z=$z maxX:$maxX maxY:$maxY"
  for (( x=0; x<=$maxX; x++ )); do
    for (( y=0; y<=$maxY; y++ )); do
      path=$z/$x
      file="$path/$y.terrain"
      if [ ! -d $path  ]; then
        mkdir -p $path
      fi

      if [ ! -f "$file"  ]; then
        curl -s "https://www.terrainserver.com/serveTerrain/world/$z/$x/$y.terrain?v=1.1.1" -o $file
      fi

      if [ "`cat $file`" = "Not Found" ]; then
        rm $file
        echo "$file not found."
      else
        echo "$file is found."
      fi

    done
  done
done

