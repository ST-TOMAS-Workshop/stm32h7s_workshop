Makefile:;

makefile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
makefile_dir := $(dir $(makefile_path))


.PHONY: %

%: 
	$(MAKE) -C $(makefile_dir) -f makefile_boot $@
	$(MAKE) -C $(makefile_dir) -f makefile_appli $@
