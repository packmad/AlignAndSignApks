#!/bin/bash

if [ -d "$1" ]; then
    apktool build $1 
    dist="$1/dist/"
    cd $dist

    outapk="out.apk"
    if [ -f $outapk ]; then
        rm $outapk
        echo "Removed old $outapk"
    fi
    
    align=$(zipalign -f -v 4 *.apk $outapk | tail -1)
    if [[ $align = "Verification succesful" ]]; then
        echo "$outapk aligned"
        sign=$(jarsigner -sigalg SHA1withRSA -digestalg SHA1 -keystore ~/.android/debug.keystore $outapk androiddebugkey -storepass android)
        if [[ $sign = "jar signed."* ]]; then
            echo "$outapk signed"
            adbdevices=$(adb devices | wc -l)
            if [[ $adbdevices = "3" ]]; then
                adbinstall=$(adb install -r $outapk)
                if [[ $adbinstall = "Success" ]]; then
                    echo "$outapk installed"
                fi
            fi
        fi
    fi
fi

