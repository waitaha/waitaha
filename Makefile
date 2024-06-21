mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(shell dirname $(mkfile_path))
WAITAHA_BR2 := $(current_dir)/buildroot
WAITAHA_BR2_EXTERNAL := $(current_dir)/waitaha-br2-external
SUPPORTED_DEVICES := $(shell ls $(WAITAHA_BR2_EXTERNAL)/board -I waitaha)
CONFIGS_DIR := $(WAITAHA_BR2_EXTERNAL)/configs
BASE_DEFCONFIG := $(CONFIGS_DIR)/waitaha_defconfig
CONFIGS_FILE := $(WAITAHA_BR2_EXTERNAL)/board/$(DEVICE)/configs
MERGE_CONFIG := $(WAITAHA_BR2)/support/kconfig/merge_config.sh

.PHONY: all
all: merge_configs build_image

.PHONY: check_device_valid
check_device_valid:
	@echo "Checking whether device is valid..."
	@if [ -z "$(DEVICE)" ]; then \
		echo "Error: DEVICE is not set. Please specify a device, e.g., 'make DEVICE=davinci' or 'make davinci"; \
		exit 1; \
	elif [ -z "$(findstring $(DEVICE),$(SUPPORTED_DEVICES))" ]; then \
		echo "Error: Device '$(DEVICE)' is not supported."; \
		exit 1; \
	fi

.PHONY: merge_configs
merge_configs: check_device_valid
	@echo "Merging configurations for $(DEVICE)..."
	$(eval CONFIG_LIST := $(shell sed 's:^:$(WAITAHA_BR2_EXTERNAL)/configs/:;s:$$:_defconfig:' $(CONFIGS_FILE)))
	@echo "Configs: $(CONFIG_LIST)"
	$(MERGE_CONFIG) -O $(CONFIGS_DIR) -m $(BASE_DEFCONFIG) $(CONFIG_LIST)
	mv $(CONFIGS_DIR)/.config $(CONFIGS_DIR)/generated_defconfig

.PHONY: build_image
build_image:
	@echo "Running make generated_defconfig..."
	$(MAKE) -C buildroot BR2_EXTERNAL=$(WAITAHA_BR2_EXTERNAL) generated_defconfig
	$(MAKE) -C buildroot BR2_EXTERNAL=$(WAITAHA_BR2_EXTERNAL) waitaha-ui-rebuild all

.PHONY: $(SUPPORTED_DEVICES)
$(SUPPORTED_DEVICES):
	$(MAKE) DEVICE=$@

.PHONY: clean
clean:
	rm -rf out/{*,.*}
	$(MAKE) -C buildroot clean
