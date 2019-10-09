<CsoundSynthesizer>
<CsOptions>
-o dac -i adc 
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

#define FFTSIZE #1024#
#define BINS #$FFTSIZE/2#

gkArr[] init $FFTSIZE
gkAmp[] init $BINS
gkFrq[] init $BINS 
gkAmpSorted[] init $BINS 
gkFrqSorted[] init $BINS 

instr 1
	kThresDb = -90
	kThres = ampdb(kThresDb)
	kMinTim = 0.18
	kLastAnalysis init i(kMinTim)
	kLastAnalysis += ksmps/sr

	aSig inch 1
	fSig pvsanal aSig, $FFTSIZE, $FFTSIZE/4, $FFTSIZE, 1
	kRms rms aSig 
	if (kRms > kThres && kLastAnalysis > kMinTim) then 
		kFrame pvs2tab gkArr, fSig
		event "i", 2, 0, 1
		kLastAnalysis = 0
	endif
endin

instr 2
	kCount = 0
	kI = 2
	loop_1:
		gkAmp[kCount] = gkArr[kI]
		gkFrq[kCount] = gksmps + kArr[kI+1]
		kCount += 1
	loop_lt kI, 2, $FFTSIZE, loop_1

	kTabI = 0
	loop_2:
		kMax maxarray gkAmp 
		kI = 0
		loop_3:
			if(gkAmp[kI] == kMax) then
				gkAmpSorted[kTabI] = gkAmp[kI]
				gkFrqSorted[kTabi] = gkFrq[kI]
				gkAmp[kI] = -1
			endif
		loop_lt kI, 1, $BINS, loop_3
	loop_lt kTabI, 1, $BINS, loop_2

	kI2 = 0
	until (kI2 == 10) do
		event "i", 3, 0, 0.01, gkAmpSorted[kI2], gkFrqSorted[kI2]
		kI2 += 1
	od 
turnoff
endin

instr 3
	iAmp = p4
	iFrq = p5
	aImp mpulse 0.9, p3
	iQ ntrpol 10, 300, 1
	aMode mode aImp, iFrq, iQ
	aEnv linseg 0, p3/2, 1, p3/2, 0
	outs aMode*aEnv*iAmp*20, aMode*aEnv*iAmp
endin

</CsInstruments>
<CsScore>
	i 1 0 60
</CsScore>
</CsoundSynthesizer>