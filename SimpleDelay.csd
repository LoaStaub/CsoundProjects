<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmpr = 32
nchnls = 2
0dbfs = 1

gaSig init 0

instr 1
    aIn pluck .7, 200, 1000, 0,1
    out aIn, aIn
    gaSig += aIn
endin

instr 2
	iFeedback = .9
	aBuf1 delayr 1
	aDelL deltapi .4
	aDelC deltapi 1
	delayw gaSig + (aDelL * iFeedback)

	aBuf2 delayr 1
	kDel line 1, p3, .01
	aDelR deltapi 3 * kDel
	delayw gaSig + (aDelL * iFeedback)
	outs aDelL + aDelC, aDelR + aDelC
endin

instr 99
    clear gaSig
endin

</CsInstruments>
<CsScore>
i 1 0 10
i 2 0 10
i 99 0 10
</CsScore>
</CsoundSynthesizer>