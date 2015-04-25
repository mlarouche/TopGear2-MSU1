@ECHO OFF

del /q TopGear2_MSU1.zip
del /q TopGear2_MSU1_Music.7z

mkdir TopGear2_MSU1
ucon64 -q --snes --chk topgear2_msu1.sfc
ucon64 -q --mki=topgear2_original.sfc topgear2_msu1.sfc
copy topgear2_msu1.ips TopGear2_MSU1
copy README.txt TopGear2_MSU1
copy topgear2_msu1.msu TopGear2_MSU1
copy topgear2_msu1.xml TopGear2_MSU1
copy manifest.bml TopGear2_MSU1
"C:\Program Files\7-Zip\7z" a -r TopGear2_MSU1.zip TopGear2_MSU1

"C:\Program Files\7-Zip\7z" a TopGear2_MSU1_Music.7z *.pcm

del /q topgear2_msu1.ips
rmdir /s /q TopGear2_MSU1