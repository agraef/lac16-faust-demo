
// ex02.dsp: add requisite meta information

declare name "ex02: sine";
declare description "basic sine generator";
declare author "Albert Graef";
declare version "0.2";

import("music.lib"); // for the osc function

// controls
freq	= nentry("freq", 440, 20, 20000, 1);	// Hz

process	= osc(freq);
