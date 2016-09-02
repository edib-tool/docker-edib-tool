# in-container package builder

include edib/shared.mk

export TIMESTAMP         := $(shell date -u +"%Y%m%d_%H%M%S")
export NAMED_TARBALL_DIR  = $(TARBALLS_DIR)/$(TIMESTAMP)
export NAMED_ROOTFS       = $(APP_NAME)-$(APP_VER).tar.gz
export NAMED_TARBALL      = $(NAMED_TARBALL_DIR)/$(NAMED_ROOTFS)
export LINKED_TARBALL     = $(TARBALLS_DIR)/$(NAMED_ROOTFS)

all: artifact

artifact: tarball
	@echo Write artifact data for the image step
	$(MAKE) -f edib/make-artifact.mk

tarball: $(NAMED_TARBALL)

$(NAMED_TARBALL): app-release
	$(MAKE) -f edib/make-tarball.mk

app-release: prerequisites
	$(MAKE) -f edib/make-app.mk

prerequisites: distillery

distillery:
	$(MAKE) -f edib/check-distillery.mk

.PHONY: all app-release artifact distillery prerequisites tarball
