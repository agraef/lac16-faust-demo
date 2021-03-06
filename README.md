
A quick rundown of the LAC 2016 faust-lv2/faust-vst plugin demo
===============================================================

Albert Gräf <aggraef@gmail.com>

More information about the workshop is available at:
<http://minilac.linuxaudio.org/index.php/Workshop#Plugin_Programming_with_Faust>

ex01.dsp: basic sine generator
------------------------------

Minimalistic, just a sine oscillator with a frequency control. Note that the
dsp is implemented by the `process` function (Faust's `main`) and the controls
(a.k.a. "Faust UI elements") are special signal-valued functions. Create a
MIDI track in Qtractor and add the plugin there.

ex02.dsp: add requisite meta information
----------------------------------------

Add a proper plugin name, description, author etc. information. Qtractor shows
the name in the plugin list (LV2 only) and some of the information in the
About tab of the plugin properties.

ex03.dsp: add a few partials and gain/gate controls
---------------------------------------------------

Add two partials along with corresponding amplitude controls to make the sound
more interesting. This also demonstrates the use of Faust macros a.k.a.
pattern-matching definitions in the definition of the amplitude sliders of the
three partials.

Also add `gain` (number) and `gate` (button) controls as a means to change the
volume of the sound and switch it on and off. (Not quite coincidentally, the
`freq`, `gain` and `gate` controls already have the special names of the
"voice" controls required to create an instrument, we'll make good use of this
in ex05.dsp.)

Note the clicks when turning the sound on and off with the `gate` button.
We'll take care of this in ex04.dsp.

ex04.dsp: add an envelop, master volume and pan controls
--------------------------------------------------------

Add a proper amplitude envelop using the `adsr` function from the Faust
library which gets triggered by the `gate` control. Note that we replace the
simple `gate` factor in the `process` function with the construct
`(gate : adsr(attack, decay, sustain, release))`. This pipes the `gate` signal
into the `adsr` function which returns the envelop signal. The parameters of
the ADSR envelop can be changed with the `attack`, `decay`, `sustain`,
`release` controls. Note the labelling of the ADSR controls (`[1]`, `[2]`
etc., this makes sure that the controls are shown in the order we want, not
the default alphabetical order).

We also add "master" volume and panning controls here, so that the output is
now a stereo signal. The extra master volume control lets us control the
volume of all voices simultaneously once we turn the dsp into an instrument.

ex05.dsp: add `nvoices` meta data to create an instrument
-------------------------------------------------------

The stage is now set to turn our little dsp into a polyphonic instrument which
takes MIDI note input. This is done with the following declaration which also
specifies the maximum polyphony:

    declare nvoices "16";

The architecture takes care of allocating as many instances of the dsp
("voices") as needed. It also assigns notes to voices, feeds the proper
`freq`, `gain`, `gate` values into playing voices and operates the other
controls in lockstep. The actual number of voices becomes an automatable
parameter as well (initially it's half the number of available voices).

ex06.dsp: add some GUI hints and MIDI control
---------------------------------------------

To make the custom GUI look prettier, we add some grouping of the controls
(note the path-like control labels, `v:` denotes vertical, `h:` horizontal
groups) and styling (`[style:knob]`).

We also add some special meta data (`[midi:ctrl 7]` etc.) to the pan and
volume controls to assign these to MIDI CC 7 and 8, respectively. Qtractor
always passes on CC data in a track to a plugin, so this lets us do old-school
MIDI-based automation by adding some CC data to the track (use Qtractor's
piano roll editor for that). You can also pipe MIDI CC data from a connected
MIDI controller into the track to operate the controls in real-time (to make
this work in Qtractor, set up the MIDI connections accordingly and make sure
that the track is armed).

MIDI-based automation is used less these days as DAWs provide their own
automation and MIDI learn facilities. The controls of the Faust-generated LV2
and VST plugins are all automatable. To do this in Qtractor, use the
automation menu in the track head to add automation lanes and edit the
automation curves there. Qtractor also allows you to assign a MIDI controller
to a plugin parameter by right-clicking on the control in the plugin's
properties dialog. You can also configure a separate MIDI control input for
that.

**NOTE:** There's an important difference between DAW-based and direct MIDI
control. Faust-generated LV2 and VST plugins are fully *multi-timbral*, i.e.,
they keep track of the control data for individual MIDI channels, which is
important when playing back multi-channel MIDI files on a single track. In
contrast, DAW MIDI control and automation always applies to all MIDI channels
on a track.

Also note that Qtractor still keeps on sending data for CCs even if they have
been assigned at the DAW level. In general it's better to remove the CC
assignments in the Faust source when using DAW based automation and MIDI
control. This can also be done on the fly, without touching the Faust source,
by invoking the compilation scripts with the `-nomidicc` option.

Finally, note the zipper noise when the pan and volume controls are operated
rapidly. This is fixed in ex07.dsp by applying a smoothing filter to the
control values.

MTS tuning support
------------------

All Faust-LV2 and -VST instruments can be tuned to an octave-based temperament
using either MTS sysex messages (if your DAW supports sending sysex messages
to plugins) or using a special automatable `tuning` parameter. For the latter,
create the `~/.faust` directory and drop the included `tuning` folder with
some MTS sysex files there.

If you want more tuning files, have a look at the author's `sclsyx` utility
which can generate MTS sysex files in the required format from Scala files.
The package includes an abundance of historic and contemporary temperaments.
The program can be found at <https://bitbucket.org/agraef/sclsyx>.

**NOTE:** The contents of `~/.faust/tuning` is read at plugin initialization
time and the corresponding control is then configured accordingly. This works
without further ado with VST and when using LV2 with dynamic manifests
(`faust2lv2 -dyn-manifest`). If your host doesn't support dynamic manifests,
the LV2 plugin manifests need to be regenerated by recompiling the plugins
every time the contents of `~/.faust/tuning` changes.

Running LV2 plugins in Pd
-------------------------

LV2 plugins can be run in Pd using the author's `lv2plugin~` external, which
can be found at: <https://bitbucket.org/agraef/pd-lv2plugin>

The external also works fine with faust-lv2 plugins. Note that `lv2plugin~`
doesn't support custom plugin GUIs at present, but it can generate generic Pd
GUIs for hosted plugins as GOP subpatches. A demo patch using some of the
faust-lv2 plugin examples can be found in the Pd subdirectory. Please see the
README file there for details.
