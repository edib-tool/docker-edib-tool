# tarball builder

include edib/shared.mk

ROOTFS              = $(STAGE_DIR)/rootfs
ROOTFS_BIN          = $(ROOTFS)/bin
ROOTFS_SH           = $(ROOTFS_BIN)/sh
ROOTFS_APP          = $(ROOTFS)/app
ROOTFS_APP_BIN      = $(ROOTFS_APP)/bin
BUSYBOX             = /bin/busybox
SYSTEM_FILES        = $(shell $(TOOLS_DIR)/libdeps)
SOURCE_FILES        = $(SYSTEM_FILES) $(BUSYBOX)
ROOTFS_SYSTEM_FILES = $(SOURCE_FILES:%=$(ROOTFS)%)

ESZ_CMD = $(TOOLS_DIR)/ex_strip_zip
# beam file stripping
ifdef RELEASE_STRIP
ESZ_STRIP = $(ESZ_CMD) strip $(ROOTFS_APP)
else
ESZ_STRIP = @echo "(No stripping of beam files.)"
endif
# application zipping
ifdef RELEASE_ZIP
ESZ_ZIP = $(ESZ_CMD) zip $(ROOTFS_APP)
else
ESZ_ZIP = @echo "(No zipping of OTP applications.)"
endif

all: info tarball postinfo

info:
	@echo "Packaging your app ..."

postinfo:
	@echo "... finished!"

tarball: $(NAMED_TARBALL) $(LINKED_TARBALL)

$(LINKED_TARBALL): $(NAMED_TARBALL)
	cd $(@D) && ln -sf $(TIMESTAMP)/$(@F) $(@F)

$(NAMED_TARBALL): $(ROOTFS_SYSTEM_FILES) $(ROOTFS_SH) $(ROOTFS_APP_BIN)
	mkdir -p $(@D) && cd $(ROOTFS) && tar -czvf $@ .

$(ROOTFS_SYSTEM_FILES): $(ROOTFS)%: $(ROOTFS)
	cp -vfa --parents $* $(ROOTFS)/

$(ROOTFS_SH): $(ROOTFS_BIN)
	$(BUSYBOX) --install -s $(ROOTFS_BIN)

$(ROOTFS_BIN): $(ROOTFS)
	mkdir -p $@

$(ROOTFS): $(STAGE_DIR)
	mkdir -p $@

$(STAGE_DIR):
	mkdir -p $@

$(ROOTFS_APP_BIN): $(ROOTFS_APP)
	tar -xzf $(RELEASE_FILE) -C $(ROOTFS_APP)
	$(ESZ_STRIP)
	$(ESZ_ZIP)
	rm -rf $(ROOTFS_APP)/$(RELEASE)

$(ROOTFS_APP): $(ROOTFS)
		mkdir -p $@

.PHONY: all info postinfo tarball
