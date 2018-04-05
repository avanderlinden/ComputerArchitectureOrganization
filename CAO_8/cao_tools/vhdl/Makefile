# Provided via commandline:
# MEMORY_S		: .s file (complete path: path is assumed to contain th e VHDL files as well!)
# VHDL_TOOLS_DIR	: directory containing the VHDL tools (inside the application path)

# Given settings
VHDL_FILES	:= alu.vhdl alucontrol.vhdl control.vhdl extend.vhdl jump.vhdl mips.vhdl mips_tb.vhdl pc.vhdl registers.vhdl
WORKDIR		:= work/
DESIGN		:= mips_tb
SIMULATION_TIME	:= 300ns

# Generated names:
VHDL_FILES_DIR	:= $(dir $(MEMORY_S))
MEMORY_VHDL	:= $(MEMORY_S:%.s=%.vhdl)
VHDL_FILES	:= $(addprefix $(VHDL_FILES_DIR),$(VHDL_FILES)) $(MEMORY_VHDL)
WORKDIR		:= $(addprefix $(VHDL_FILES_DIR),$(WORKDIR))

OBJ_FILES	:= $(addprefix $(WORKDIR),$(VHDL_FILES:%.vhdl=%.o))
WAVE_FILE	:= $(addprefix $(WORKDIR),$(DESIGN:%=%.ghw))
SAV_FILE	:= $(addprefix $(VHDL_TOOLS_DIR),$(DESIGN:%=%.sav))
DESIGN_FILE	:= $(addprefix $(WORKDIR),$(DESIGN))

# Programs:
MIPS_TO_VHDL	:= $(addprefix $(VHDL_TOOLS_DIR),mips_to_vhdl.awk)

GHDL		:= ghdl
GHDL_FLAGS	:= --workdir=$(WORKDIR)
GHDL_RUN_FLAGS	:= --wave=$(WAVE_FILE) --stop-time=$(SIMULATION_TIME)

GTKWAVE		:= gtkwave
GTKWAVE_FLAGS	:= --save=$(SAV_FILE)

# Rules
all:		$(WAVE_FILE)
		$(GTKWAVE) $< $(GTKWAVE_FLAGS)

$(WAVE_FILE):	$(DESIGN_FILE)
		$(abspath $<) $(GHDL_RUN_FLAGS)

$(MEMORY_VHDL):	$(MEMORY_S)
		awk -vOUTPUT_FILE=$@ -f $(MIPS_TO_VHDL) $<

$(DESIGN) $(DESIGN_FILE):	$(OBJ_FILES) | $(WORKDIR)
		$(GHDL) -e -o $(DESIGN_FILE) $(GHDL_FLAGS) $(DESIGN)

$(WORKDIR)%.o:	%.vhdl | $(WORKDIR)
		$(GHDL) -a $(GHDL_FLAGS) $<

$(WORKDIR):
		mkdir $@

.PHONY:		all
