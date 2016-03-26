
// ex06.dsp: add some GUI hints and MIDI control

declare name "ex06: synth";
declare description "basic additive synthesizer";
declare author "Albert Graef";
declare version "0.6";

// This declares that the module is an instrument with 16-voice polyphony.
declare nvoices "16";

import("music.lib"); // for the osc function

// voice controls
freq	= nentry("/freq", 440, 20, 20000, 1);	// Hz
gain	= nentry("/gain", 0.3, 0, 10, 0.01);	// %
gate	= button("/gate");			// 0/1

// relative amplitudes of the different partials
amp(1)	= vslider("/h:[1]/amp1", 1.0, 0, 3, 0.01);
amp(2)	= vslider("/h:[1]/amp2", 0.5, 0, 3, 0.01);
amp(3)	= vslider("/h:[1]/amp3", 0.25, 0, 3, 0.01);

// adsr controls
attack	= hslider("/v:[2]/[1] attack", 0.01, 0, 1, 0.001);	// sec
decay	= hslider("/v:[2]/[2] decay", 0.3, 0, 1, 0.001);	// sec
sustain = hslider("/v:[2]/[3] sustain", 0.5, 0, 1, 0.01);	// %
release = hslider("/v:[2]/[4] release", 0.2, 0, 1, 0.001);	// sec

// master controls (volume and stereo panning)
vol	= vslider("/h:[3]/vol [style:knob] [midi:ctrl 7]", 0.3, 0, 1, 0.01);
pan	= vslider("/h:[3]/pan [style:knob] [midi:ctrl 8]", 0.5, 0, 1, 0.01);

// partial #i (0..n-1)
partial(i) = amp(i+1)*osc((i+1)*freq);

process	= sum(i, 3, partial(i))*gain
	  * (gate : adsr(attack, decay, sustain, release))
	  * vol : panner(pan);
