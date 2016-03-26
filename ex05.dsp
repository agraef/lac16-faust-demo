
// ex05.dsp: add nvoices meta data to create an instrument

declare name "ex05: synth";
declare description "basic additive synthesizer";
declare author "Albert Graef";
declare version "0.5";

// This declares that the module is an instrument with 16-voice polyphony.
declare nvoices "16";

import("music.lib"); // for the osc function

// voice controls
freq	= nentry("freq", 440, 20, 20000, 1);	// Hz
gain	= nentry("gain", 0.3, 0, 10, 0.01);	// %
gate	= button("gate");			// 0/1

// relative amplitudes of the different partials
amp(1)	= vslider("amp1", 1.0, 0, 3, 0.01);
amp(2)	= vslider("amp2", 0.5, 0, 3, 0.01);
amp(3)	= vslider("amp3", 0.25, 0, 3, 0.01);

// adsr controls
attack	= hslider("[1] attack", 0.01, 0, 1, 0.001);	// sec
decay	= hslider("[2] decay", 0.3, 0, 1, 0.001);	// sec
sustain = hslider("[3] sustain", 0.5, 0, 1, 0.01);	// %
release = hslider("[4] release", 0.2, 0, 1, 0.001);	// sec

// master controls (volume and stereo panning)
vol	= vslider("vol", 0.3, 0, 1, 0.01);
pan	= vslider("pan", 0.5, 0, 1, 0.01);

// partial #i (0..n-1)
partial(i) = amp(i+1)*osc((i+1)*freq);

process	= sum(i, 3, partial(i))*gain
	  * (gate : adsr(attack, decay, sustain, release))
	  * vol : panner(pan);
