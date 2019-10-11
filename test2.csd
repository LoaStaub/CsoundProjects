<CsoundSynthesizer>
<CsInstruments>
sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 2
0dbfs = 1
#define Hanoi # 1 #
#define Sine  # 2 #
#define DURATION # 0.1 #
#define DISCS    # 10 #
gk_c init 0
opcode Hanoi, i, iiii
    i_n, ia, ic, ib xin
    
    if i_n != 0 then
        ifoo Hanoi i_n - 1, ia, ib, ic
        event "i", $Sine, gk_c, 1, i_n, ia, ic
        printf "Move plate %i from %i to %i at %f\n", 1, i_n, ia, ic, gk_c 
        ifoo Hanoi i_n - 1, ib, ic, ia
    else
        gk_c = gk_c + $DURATION
    endif
    
    xout 1
endop
instr $Hanoi
    idiscs = p4
    ifoo Hanoi idiscs, 1, 2, 3
    
    turnoff
endin
instr $Sine
    p3 = $DURATION
    idur = p3
    i_n = p4
    ia = (p5 - 1) / 2
    ic = (p6 - 1) / 2
    
    aenv linseg 0, 0.01, 1, idur - 0.02, 1, 0.01, 0
    a1 oscil 0.707 * aenv, 440 * ($DISCS - i_n), 1, -1
    a2 line ia, idur, ic
    
    outs a1 * sqrt(a2), a1 * sqrt(1 - a2)
endin
</CsInstruments>
<CsScore>
#define Hanoi # 1 #
#define Sine  # 2 #
#define DURATION # 0.1 #
#define DISCS    # 10 #
f 1 0 [2 ^ 16] 10 1
i $Hanoi 0 1 $DISCS
e [(2 ^ $DISCS - 1) * $DURATION]
</CsScore>
</CsoundSynthesizer>