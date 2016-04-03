`lv2plugin~`
============

This folder contains a few demo patches showing how to run LV2 plugins in Pd
using the `lv2plugin~` external available at:

<https://bitbucket.org/agraef/pd-lv2plugin>

To run the patch, you must install the external. Arch users can find the
`lv2plugin~` external and all its dependencies in the AUR (look for the
`pd-lv2plugin-git` package). You'll also have to install the `pd-pure` package
and enable it in Pd. Please check the link above for details, or try the
abridged instructions below.

The patch uses some of the faust-lv2 example plugins, so you'll have to
install these first. Some presets for the subtractive synth are included as
well (`subtractive-presets.lv2` folder), just copy the bundle to your `~/.lv2`
directory to make them work.

NB: The generic plugin GUIs (GOP subpatches) in the demo patch are
auto-generated and will be overwritten each time the patch is loaded. If you
edit these manually and want to preserve your edits, change the subpatch names
before saving the patch.

Installing pd-pure
------------------

To run Pure externals like `lv2plugin~`, you must have the Pure interpreter as
well as the Pd Pure plugin loader `pd-pure` installed. In addition, the
`lv2plugin~` external needs the `pure-lilv` module (as well as the `lilv`
library itself, which should be readily available in your Linux distribution).
The process to get all these up and running isn't really that complicated, but
may require a little work since not all Linux distributions have a recent Pure
version and its modules in their repositories.

The needed sources are all available from the Pure website at
<http://purelang.bitbucket.org/>. Arch users can also find a complete set of
Pure packages in the AUR, Mac users have the same available in MacPorts,
please check the information on the Pure website for details. These packages
will also pull in all the required dependencies.

If you need/want to compile from source, grab the Pure Mercurial repository at
<https://bitbucket.org/purelang/pure-lang> and make sure that you have the
required dependencies installed. Pure needs LLVM 3.5 or earlier, `libgmp`,
`libmpfr` and the `readline` library; for the `pd-pure` and `pure-lilv`
modules you'll need Pd and the `lilv` library, respectively. These should all
be readily available in your distro's repositories. Then follow the
instructions in the corresponding README files to install these three modules
from the Pure repository sources: `pure`, `pd-pure` and `pure-lilv`. (The
`pure` module needs to be installed first, as it contains the Pure base system
including the interpreter and the standard library.)

Finally, you also need to enable `pd-pure` in Pd. To do this, add `-lib pure`
to your Pd startup options and restart Pd (some Pd versions also have a
special dialog which allows you to enter `pure` as a library to be loaded on
startup).

Once `pd-pure` displays its sign-on message in the Pd main window, you should
be ready to install and run the `lv2plugin~` external. Congrats! :)
