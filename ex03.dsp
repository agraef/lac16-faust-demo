
// ex03.dsp: add a few partials and gain/gate controls

declare name "ex03: sine";
declare description "basic sine generator";
declare author "Albert Graef";
declare version "0.3";

import("music.lib"); // for the osc function

// controls
freq	= nentry("freq", 440, 20, 20000, 1);	// Hz
gain	= nentry("gain", 0.3, 0, 10, 0.01);	// %
gate	= button("gate");			// 0/1

// relative amplitudes of the different partials
amp(1)	= vslider("amp1", 1.0, 0, 3, 0.01);
amp(2)	= vslider("amp2", 0.5, 0, 3, 0.01);
amp(3)	= vslider("amp3", 0.25, 0, 3, 0.01);

// partial #i (0..n-1)
partial(i) = amp(i+1)*osc((i+1)*freq);

process	= sum(i, 3, partial(i))*gain*gate;
