<CsoundSynthesizer>
<CsInstruments>
sr = 44100
kr = 4410
ksmps = 10
nchnls = 2
0dbfs = 32768
instr Bubbles
    idur = p3
    igain = p4
    ipan = p5
    ibw = p6
    ibubble = p7
    iseed = p8
    iattack = p9
    idecay = p10
    ires1 = 925
    ires2 = 950
    ires3 = 975
    arand1 randh 10000, ibubble, iseed
    aosc1 oscil 10000, arand1, 1
    kgain linseg 0.1, iattack, igain, idur - (iattack + idecay), igain,\
                  idecay, 0.1
    asig1 reson aosc1, ires1, ibw
    asig2 reson aosc1, ires2, ibw
    asig3 reson aosc1, ires3, ibw
    again1 gain asig1, kgain
    again2 gain asig2, kgain
    again3 gain asig3, kgain
    amix = again1 + again2 + again3
    alpf1 butterlp amix, 5000
    alpf1 butterlp amix, 5000
    aleft = alpf1 * (1 - ipan)
    aright = alpf1 * ipan
    outs aleft, aright
    chnmix alpf1, "verb"
endin
instr Breath
    idur = p3
    iamp = p4
    iattack = p5
    idecay = idur - iattack
    kenv1 expseg 0.1, iattack, iamp, idecay, 0.1
    aosc1 oscil kenv1, 440, 2
    kenv2 line 500, idur, 1250
    kenv3 expon 0.5, idur, 0.05
    ares reson aosc1, kenv2, kenv2 * kenv3, 1
    ares reson ares, kenv2, kenv2 * 0.5, 1
    ares balance ares, aosc1
    outs ares, ares
endin
instr Reverb
    idur = p3
    asig chnget "verb"
    kfn oscil1i 0, 1, idur, 100
    kfn =  kfn * 0.1
    kfn2 oscil1i 0, 1, idur, 101
    kfn3 oscil1i 0, 1, idur, 102
    arev reverb  asig * kfn, kfn2
    arev2 reverb2 asig * kfn, kfn3, 0.5
    outs arev, arev2
    azero = 0
    chnset azero, "verb"
endin
</CsInstruments>
<CsScore>
f 1 0 8192 10 1
f 2 0 8192 21 1
f 100 0 16 -2 1   1   2   2   3   3   1   1   6 2 4   3   3   2   2   4
f 101 0 16 -2 0.5 1   0.7 0.6 0.5 0.2 0.1 0.1 2 1 0.5 0.4 0.3 0.2 0.3 0.5
f 102 0 16 -2 0.2 0.1 0.1 0.5 1   0.7 0.6 0.5 2 1 0.4 0.3 0.2 0.3 0.4 0.5
i "Reverb" 0 240
i "Bubbles" 0   40 800 0.5 15   200 1   15 15
i "Bubbles" 30  35 650 0.0 17   188 0.1 5  10
i "Bubbles" 30  40 650 1.0 16   185 0.2 10 5
i "Bubbles" 50  40 900 0.5 5    115 0.3 15 5
i "Bubbles" 75  47 300 0.0 10   190 0.4 10 2
i "Bubbles" 75  45 300 0.5 7    135 0.5 2  5
i "Bubbles" 75  43 300 1.0 11   207 0.6 5  10
i "Bubbles" 115 40 900 0.5 15.5 145 0.7 15 5
i "Breath" 150 25 20000 8 12
i "Bubbles" 160 55 500  0.125 13   200 0.8 9  20
i "Bubbles" 160 55 500  0.5   14   150 0.9 7  15
i "Bubbles" 160 55 500  0.875 18   200 0.0 8  25
i "Bubbles" 200 40 500  0.5   15   200 0.1 10 25
i "Bubbles" 205 25 1100 0.0   0.15 200 0.1 15 10
i "Bubbles" 205 28 1100 0.5   0.25 200 0.1 15 10
i "Bubbles" 205 30 1100 1.0   0.14 200 0.1 15 10
</CsScore>
</CsoundSynthesizer>
