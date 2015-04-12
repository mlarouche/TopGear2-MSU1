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
constant SPC_COMM_1($2141)
constant SPC_COMM_2($2142)
constant SPC_COMM_3($2143)

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

seek($81DA3A)
	jsr MSU_FadeVolume
	
seek($81DA3F)
	jsr MSU_GameMain

seek($9FF1A3)
	jsr MSU_MenuMain

seek($9F8136)
	jsr MSU_StoreSong
	
seek($81FF80)
scope MSU_GameMain: {
	php
	rep #$20
	pha
	
	sep #$20
	CheckMSUPresence(OriginalCode)
	
	// Set track
	lda $059A
	cmp #$FF
	beq DoNothing
	cmp #$00
	beq DoNothing
	
CheckMSUAudioStatus:
	lda.w MSU_STATUS
	and.b #MSU_STATUS_AUDIO_BUSY
	bne CheckMSUAudioStatus
	
	// Check if the track is missing
	lda.w MSU_STATUS
	and.b #MSU_STATUS_TRACK_MISSING
	bne OriginalCode
	
	// Play the song and add repeat if needed
	lda #$03
	sta.w MSU_AUDIO_CONTROL
	
	// Set volume
	lda.b #FULL_VOLUME
	sta.w MSU_AUDIO_VOLUME
	
	rep #$20
	pla
	plp
	rts
	
OriginalCode:
	rep #$20
	pla
	sep #$20
	sta.w SPC_COMM_2
	plp
	rts
	
DoNothing:
	rep #$20
	pla
	plp
	rts
}

MSU_FadeVolume:
	sta.w SPC_COMM_1
	sta.w MSU_AUDIO_VOLUME
	rts
	
	if (pc() > $81FFFF) {
		error "Overflow detected"
	}
	

seek($9FFF80)
scope MSU_MenuMain: {
	php
	rep #$20
	pha
	
	sep #$20
	CheckMSUPresence(OriginalCode)
	
	lda $01C1
	bne DoNothing
	
	// Set track
	lda $01D2
	cmp #$FF
	beq DoNothing
	cmp #$00
	beq DoNothing
	
	clc
	adc.b #$03
	sta.w MSU_AUDIO_TRACK_LO
	stz.w MSU_AUDIO_TRACK_HI
	
CheckMSUAudioStatus:
	lda.w MSU_STATUS
	and.b #MSU_STATUS_AUDIO_BUSY
	bne CheckMSUAudioStatus
	
	// Check if the track is missing
	lda.w MSU_STATUS
	and.b #MSU_STATUS_TRACK_MISSING
	bne OriginalCode
	
	// Play the song and add repeat if needed
	lda #$03
	sta.w MSU_AUDIO_CONTROL
	
	// Set volume
	lda.b #FULL_VOLUME
	sta.w MSU_AUDIO_VOLUME
	
	rep #$20
	pla
	plp
	rts
	
OriginalCode:
	rep #$20
	pla
	sep #$20
	sta.w SPC_COMM_2
	plp
	rts
	
DoNothing:
	rep #$20
	pla
	plp
	rts
}

scope MSU_StoreSong: {
	sta $01C1
	php
	sep #$20
	sta.w MSU_AUDIO_TRACK_LO
	stz.w MSU_AUDIO_TRACK_HI
	plp
	rts
}

	if (pc() > $9FFFFF) {
		error "Overflow detected"
	}
	
