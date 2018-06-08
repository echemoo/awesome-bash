#!/bin/bash
# desc: download resource
# author: echemoo@gmail.com
echo "[echemoo] Download Resource of SRTM 90M Data"
#http://srtm.csi.cgiar.org/SRT-ZIP/SRTM_V41/SRTM_Data_GeoTiff/srtm_54_05.zip

url=""
for (( x=1; x<=72; x++ )); do
    for (( y=1; y<=24; y++ )); do
        url="http://srtm.csi.cgiar.org/SRT-ZIP/SRTM_V41/SRTM_Data_GeoTiff/srtm_`printf \"%02d\" $x`_`printf \"%02d\" $y`.zip"
		filename="srtm_`printf \"%02d\" $x`_`printf \"%02d\" $y`.zip"
		if [ -f $filename ] ; then
			echo "$filename is ok."
			continue
		fi
        curl $url -fs --head >> /dev/null
        if [ $? -eq 0 ] ; then
            #curl -O $url -s
            echo "$filename is done."
        else
            echo "$filename is not found."
        fi
    done
done

echo "[echemoo] End"
exit 0
