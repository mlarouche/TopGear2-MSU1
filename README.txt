Top Gear 2 MSU-1
Version 1.1
by DarkShock

This hack adds CD quality audio to Top Gear 2 using the MSU-1 chip invented by byuu.
The hack has been tested on SD2SNES and higan 094. The patched ROM needs to be named topgear2_msu1.sfc.

===============
= Using higan =
===============
1. Patch the ROM
2. Launch it using higan
3. Go to %USERPROFILE%\Emulation\Super Famicom\topgear2s_msu1.sfc in Windows Explorer.
4. Copy manifest.bml and the .pcm file there
5. Run the game

===============
= Using BSNES =
===============
Just patch the ROM and launch the game. The pcm file needs to be in the same folder.

====================
= Using on SD2SNES =
====================
Drop the ROM file, topgear2_msu1.msu and the .pcm files in any folder. (I really suggest creating a folder)
Launch the game and voilà, enjoy !

===============
= Music       =
===============
The music is from the Amiga CD32 version of the game.
Find the music pack here: https://www.mediafire.com/?wipczb80tb2kben

If you want to make your own music pack, here's the music index:
01 = Auckland (First Race)
02 = Ayers Rock (Second Race)
03 = Cantebury Plains (Third Race)
04 = Title Screen
05 = Ending Theme / Results
06 = Qualified jingle

=============
= Compiling =
=============
Source is availabe on GitHub: https://github.com/mlarouche/TopGear2-MSU1

To compile the hack you need

* bass v14 (https://web.archive.org/web/20140710190910/http://byuu.org/files/bass_v14.tar.xz)
* wav2msu (https://github.com/mlarouche/wav2msu)

To distribute the hack you need

* uCON64 (http://ucon64.sourceforge.net/)
* 7-Zip (http://www.7-zip.org/)

make.bat assemble the patch
create_pcm.bat create the .pcm from the WAV files
distribute.bat distribute the patch
make_all.bat does everything
