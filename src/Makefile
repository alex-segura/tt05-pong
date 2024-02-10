# Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILATOR=verilator
VFLAGS = -O3 --x-assign fast --x-initial fast --noassert
SDL_CFLAGS = `sdl2-config --cflags`
SDL_LDFLAGS = `sdl2-config --libs`

# normal simulation
ifneq ($(GATES),yes)

# this is the only part you should need to modify:
VERILOG_SOURCES += $(PWD)/tb.v
VERILOG_SOURCES += $(PWD)/tt_pong.v
VERILOG_SOURCES += $(PWD)/pong.v
VERILOG_SOURCES += $(PWD)/debounce.v
VERILOG_SOURCES += $(PWD)/encoder.v
VERILOG_SOURCES += $(PWD)/paddle.v
VERILOG_SOURCES += $(PWD)/hvsync_generator.v

else

# gate level simulation requires some extra setup, you shouldn't need to touch this
COMPILE_ARGS    += -DGL_TEST
COMPILE_ARGS    += -DFUNCTIONAL
COMPILE_ARGS    += -DUSE_POWER_PINS
COMPILE_ARGS    += -DSIM
COMPILE_ARGS    += -DUNIT_DELAY=\#1
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v

# this gets copied in by the GDS action workflow
VERILOG_SOURCES += $(PWD)/tb.v $(PWD)/gate_level_netlist.v
endif

pong: pong.mk
	make -C	./obj_dir -f Vtop_pong.mk

%.mk: top_%.v
	$(VERILATOR) ${VFLAGS} -I.. \
		-cc $< --exe $(basename $@).cpp -o $(basename $@) \
		-CFLAGS "${SDL_CFLAGS}" -LDFLAGS "${SDL_LDFLAGS}"

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
