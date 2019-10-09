<CsoundSynthesizer>
<CsOptions>
-o dac -i adc
</CsOptions>
<CsInstruments>

sr = 44100
ksmpr = 32
nchnls = 2
0dbfs = 1

gaSig init 0

instr 1
	kMetro metro 1
	schedkwhen kMetro, 0, 0, 2, 0, 1
endin

instr 2
	aSig inch 1
	kAmp linseg 0, 0.5, 0.2, 0.5, 0
	gaSig = aSig * kAmp
endin

instr 3
	a3 init 0
	kAmp linseg 0, 1, 0.2, 1, 0
	aSin oscil3 kAmp, 440, -1
	aDel1 oscil3 0.0223, 0.023, -1
	aDel2 oscil3 0.0521, 0.023, -1, 0.5
	aDel1 randi 0.02, 0.2, 2

	a0 delayr 1
	a1 deltapi aDel1 + 0.1
	a2 deltapi aDel2 + 0.1

	kRms rms a3
	delayw gaSig + exp(-kRms) * a3
	a3 reson -(a1 + a2), 3000, 7000, 2
	outs a1/3, a2/3
endin

</CsInstruments>
<CsScore>
i 1 0 100
i 3 0 100
</CsScore>
</CsoundSynthesizer>