arch snes.cpu

// MSU memory map I/O
constant MSU_STATUS($2000)
constant MSU_ID($2002)
constant MSU_AUDIO_TRACK_LO($2004)
constant MSU_AUDIO_TRACK_HI($2005)
constant MSU_AUDIO_VOLUME($2006)
constant MSU_AUDIO_CONTROL($2007)

// SPC communication ports
constant SPC_COMM_0($2140)

// MSU_STATUS possible values
constant MSU_STATUS_TRACK_MISSING($8)
constant MSU_STATUS_AUDIO_PLAYING(%00010000)
constant MSU_STATUS_AUDIO_REPEAT(%00100000)
constant MSU_STATUS_AUDIO_BUSY($40)
constant MSU_STATUS_DATA_BUSY(%10000000)

// Constants
if {defined EMULATOR_VOLUME} {
	constant FULL_VOLUME($60)
	constant DUCKED_VOLUME($20)
	constant FADE_DELTA(1)
} else {
	constant FULL_VOLUME($FF)
	constant DUCKED_VOLUME($60)
	constant FADE_DELTA(2)
}

// Variables
variable fadeState($180)
variable fadeVolume($181)

// FADE_STATE possibles values
constant FADE_STATE_IDLE($00)
constant FADE_STATE_FADEOUT($01)
constant FADE_STATE_FADEIN($02)

// **********
// * Macros *
// **********
// seek converts SNES LoROM address to physical address
macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

macro CheckMSUPresence(labelToJump) {
	lda.w MSU_ID
	cmp.b #'S'
	bne {labelToJump}
}

seek($81DA3F)
	nop
	nop
	nop

seek($9FF1A3)
	nop
	nop
	nop

seek($9FFF80)
TestMSU:
	rts
