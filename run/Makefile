#############################
# User variables
#############################

SIM_DIR      =$(PROJECT_DIR)/run/sim
LOG_DIR      =$(SIM_DIR)/log
DUT_DIR      =$(PROJECT_DIR)/DUT

COMPLIST     =$(PROJECT_DIR)/testbench/tb.f
#############################


VCOMP = vcs -sverilog +v2k -LDFLAGS -Wl,--no-as-needed -l $(LOG_DIR)/comp.log -f $(COMPLIST) -debug_acc+all -top testbench

comp:
	@mkdir -p $(SIM_DIR); 
	@mkdir -p $(LOG_DIR); 
	cd $(SIM_DIR); \
	$(VCOMP)

clean:
	rm -rf sim
