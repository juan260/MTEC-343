
s.boot;

a = Bus.audio(s, 2);
b = Bus.audio(s, 2);

z = {
var input = In.ar(a, 2);
var kick = In.ar(b, 2);
var thresh = 0.01;
var compression = 0.2;
var attack = 0.01;
var release = 0.02;
var snd = Compander.ar(FreeVerb2.ar(input[0], input[1]), kick, thresh, 1, compression, attack, release)*5;
Out.ar(0, snd);
}.play;
s.scope;




SynthDef(\myFm, { | freq = 440, modFreqMul = 3, amp = 0.2, modAmp = 0.3, randomPanning = 0.5|

var modulator = SinOsc.kr(freq*modFreqMul) * modAmp;
var env = EnvGen.kr(Env.triangle(0.3,1),doneAction:2);
var carrier = SinOsc.ar(freq+(modulator*300))*env*amp;
 carrier = carrier.pow(MouseY.kr(0.1,1.0));
Out.ar(a, Pan2.ar(carrier, Rand.new(-0.9, 0.9)));
}).add;

~dancing = Pbind(
\instrument, \myFm,
\midinote, Pseq([Pshuf([55, 59, 62, 66],4),Pshuf([55, 59, 62, 66],4)-3,Pshuf([55, 59, 62, 66],4)-6],inf).trace,
\dur, Pseq([0.1, 0.2, 0.3, 0.4],inf).trace
);

~dancingplay = ~dancing.play;


SynthDef(\hardKick, {| freqA= 600, freqB=50, freqC = 10, freqDur1=0.01, freqDur2 = 0.1, freqC1=1, freqC2=(-1), atk = 0.01, rel =1, c1=1, c2=(-12) amp=1|
	var sig, env, freqSweep;
	freqSweep = Env([freqA,freqB,freqC], [freqDur1, freqDur2], [freqC1, freqC2]).ar;
	env = EnvGen.kr(Env([0,1,0], [atk, rel],[c1,c2]),doneAction:2);
	sig = SinOsc.ar(freqSweep, pi/2).cubed;
	sig = sig* env;
	Out.ar(b,sig!2);
	Out.ar(0,sig!2);
}).add;


SynthDef(\softKick, {| freqA= 0, freqB=0, freqC = 10, freqDur1=0.01, freqDur2 = 0.1, freqC1=1, freqC2=(-1), atk = 0.01, rel =1, c1=1, c2=(-12) amp=1|
	var sig, env, freqSweep;
	freqSweep = Env([freqA,freqB,freqC], [freqDur1, freqDur2], [freqC1, freqC2]).ar;
	env = EnvGen.kr(Env([0,1,0], [atk, rel],[c1,c2]),doneAction:2);
	sig = SinOsc.ar(freqSweep, pi/2);
	sig = sig* env;
	Out.ar(a,(sig*0.5)!2);
	Out.ar(0,(sig*0.1)!2);
}).add;

~softKick = Pbind(\instrument, \softKick, \dur, Pseq([1], inf), \amp, Pseq([1], inf));

~hardKick = Pbind(\instrument, \hardKick, \dur, Pseq([0.5], inf), \amp, Pseq([0.9], inf));

~softKick.play();
~hardKickplay = ~hardKick.play();

SynthDef(\bass, { | freq = 440, filterFreqMult = 5, amp = 3, resonance = 1 |
	var filteredOsc, env, output;

	filteredOsc = RLPF.ar(Saw.ar(freq)+ (Saw.ar(freq*0.009)*0.1)+ (Saw.ar(freq*1.001)*0.1) + (SinOsc.ar(freq/2)*1), filterFreqMult*freq, resonance);
	 filteredOsc = filteredOsc.pow(MouseY.kr(0.1,1.0));
	env = EnvGen.kr(Env.new([0.001,1,0.4,0.3,0.001], [0.01,0.24,0.24,0.1], 'exp'),doneAction:2);
	Out.ar(0, (filteredOsc*env*amp)!2);
}).add;

~bass = Pbind(
	\instrument, \bass,
	\midinote, Pseq([Pseq([55],8),Pseq([55],8)-3,Pseq([55],8)-6]-12,inf).trace,
	\dur, Pseq([0.5],inf).trace
);

~hardKickplay.stop;

~dancingplay.stop;
~bassplay = ~bass.play;

SynthDef(\snare, { | amp = 1.0 |
	var oscillator = WhiteNoise.ar()*amp;
	var env = EnvGen.kr(Env([0.001, 15000, 200, 3000, 0.001], [0.012,0.018, 0.018, 0.1], 'exp') ,doneAction:2);
	var filter = HPF.ar(LPF.ar(oscillator, env), 200);
	 filter = filter.pow(MouseY.kr(0.1,1.0));
	Out.ar(0, filter!2);
}).add;

~snare = Pbind(\instrument, \snare, \amp, Pseq([0.0, 0.4], inf), \dur, Pseq([0.5], inf));

~bassplay.stop;
~dancingplay = ~dancing.play;
~hardKickplay = ~hardKick.play();
~snarePlay = ~snare.play;
~bassplay = ~bass.play;

SynthDef(\myFm, { | freq = 440, modFreqMul = 2, amp = 0.2, modAmp = 0.0, randomPanning = 0.5|

	var modulator = SinOsc.kr(freq*modFreqMul) * modAmp;
	var env = EnvGen.kr(Env.triangle(0.3,1),doneAction:2);
	var carrier = SinOsc.ar(freq+(modulator*300))*env*amp;
	 carrier = carrier.pow(MouseY.kr(0.1,1.0));
	Out.ar(a, Pan2.ar(carrier, Rand.new(-0.9, 0.9)));
}).add;

SynthDef(\bass, { | freq = 440, filterFreqMult = 5, amp = 3, resonance = 1 |
	var filteredOsc, env, output;

	filteredOsc = RLPF.ar(Saw.ar(freq)+ (Saw.ar(freq*0.009)*0.1)+ (Saw.ar(freq*1.001)*0.1) + (SinOsc.ar(freq/2)*1), filterFreqMult*freq, resonance);
	 filteredOsc = filteredOsc.pow(MouseY.kr(0.1,1.0));
	env = EnvGen.kr(Env.new([0.001,1,0.4,0.3,0.001], [0.01,0.24,0.24,0.1], 'exp'),doneAction:2);
	Out.ar(0, (filteredOsc*env*amp)!2);
}).add;

SynthDef(\snare, { | amp = 1.0 |
	var oscillator = WhiteNoise.ar()*amp;
	var env = EnvGen.kr(Env([0.001, 15000, 200, 3000, 0.001], [0.012,0.018, 0.018, 0.1], 'exp') ,doneAction:2);
	var filter = HPF.ar(LPF.ar(oscillator, env), 200);
	 filter = filter.pow(MouseY.kr(0.1,1.0));
	Out.ar(0, filter!2);
}).add;

Server.killAll;