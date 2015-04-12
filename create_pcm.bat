@ECHO OFF

del *.pcm

wav2msu -o topgear2_msu1-1.pcm TopGear2_Auckland.wav
wav2msu -o topgear2_msu1-2.pcm TopGear2_Ayers_Rock.wav
wav2msu -o topgear2_msu1-3.pcm TopGear2_Cantebury_Plains.wav

wav2msu -o topgear2_msu1-4.pcm TopGear2_Title_Screen.wav
wav2msu -o topgear2_msu1-5.pcm TopGear2_Ending_Theme.wav
wav2msu -o topgear2_msu1-6.pcm TopGear2_Qualified.wav
