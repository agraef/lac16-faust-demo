
opts = -gui

source = $(sort $(wildcard ex*.dsp))
lv2 = $(source:.dsp=.lv2)
vst = $(source:.dsp=.so)

.PHONY: all lv2 vst clean install-lv2 uninstall-lv2 install-vst uninstall-vst install-tuning uninstall-tuning

all: lv2 vst
lv2: $(lv2)
vst: $(vst)

%.lv2: %.dsp
	+faust2lv2 $(opts) $<

%.so: %.dsp
	+faust2faustvst $(opts) $<

clean:
	rm -rf $(lv2) $(vst)

install-lv2: $(lv2)
	rm -rf $(addprefix ~/.lv2/, $(lv2))
	mkdir -p ~/.lv2
	cp -r $(lv2) ~/.lv2

uninstall-lv2:
	rm -rf $(addprefix ~/.lv2/, $(lv2))

install-vst: $(vst)
	mkdir -p ~/.vst
	cp $(vst) ~/.vst

uninstall-vst:
	rm -f $(addprefix ~/.vst/, $(vst))

install-tuning:
	mkdir -p ~/.faust
	rm -rf ~/.faust/tuning
	cp -r tuning ~/.faust

uninstall-tuning:
	rm -rf ~/.faust/tuning
