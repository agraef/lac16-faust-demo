// ex01.dsp: basic sine generator

import("music.lib"); // for the osc function

// controls
freq	= nentry("freq", 440, 20, 20000, 1);	// Hz

process	= osc(freq);
