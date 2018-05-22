# AlignAndSignApks

Simple bash script to align&amp;sign apks.

It assumes apktool, zipalign and jarsigner in $PATH.

Usage: ```rebuildapk.sh apktoolOutputDirectory/```

If a device is connected throught adb, the new apk is automatically installed.
