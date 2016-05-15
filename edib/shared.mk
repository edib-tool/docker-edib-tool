APPINFO_RUNNER = $(TOOLS_DIR)/app_info

SOURCE_DIR     = /source
BUILD_DIR      = /build
TOOLS_DIR      = $(BUILD_DIR)/tools

APP_DIR        = $(BUILD_DIR)/app
APP_NAME       = $(shell $(APPINFO_RUNNER) name)
APP_VER        = $(shell $(APPINFO_RUNNER) version)

MIX_ENV       ?= prod
RELEASE        = releases/$(APP_VER)/$(APP_NAME).tar.gz
RELEASE_PATH   = $(APP_DIR)/rel/$(APP_NAME)
RELEASE_FILE   = $(RELEASE_PATH)/$(RELEASE)

STAGE_DIR      = /stage
TARBALLS_DIR   = $(STAGE_DIR)/tarballs
ROOTFS_TARBALL = $(TARBALLS_DIR)/rootfs.tar.gz
