@ECHO OFF
del topgear2_msu1.sfc

copy topgear2_original.sfc topgear2_msu1.sfc

set BASS_ARG=
if "%~1" == "emu" set BASS_ARG=-d EMULATOR_VOLUME

bass %BASS_ARG% -o topgear2_msu1.sfc topgear2_msu1.asm
