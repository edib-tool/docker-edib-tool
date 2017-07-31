# app release builder

include edib/shared.mk

ifeq ($(PHOENIX_1_3), true)
ASSETS_DIR           = $(APP_DIR)/assets
DIGEST               = phx.digest
else
ASSETS_DIR           = $(APP_DIR)
DIGEST               = phoenix.digest
endif

IN_ASSETS_DIR        = cd $(ASSETS_DIR) &&
IN_APP_DIR           = cd $(APP_DIR) &&
PHOENIX              = $(shell $(APPINFO_RUNNER) phoenix)
PHOENIX_PACKAGE_JSON = $(ASSETS_DIR)/package.json
HAS_PACKAGE_JSON     = $(shell [ -f $(PHOENIX_PACKAGE_JSON) ] && echo true)
NPM_INSTALL_CMD      = npm install
NODE_MODULES         = $(ASSETS_DIR)/node_modules
NODE_BIN_DIR         = $(NODE_MODULES)/.bin
NPM_DEPLOY_CMD       = npm deploy

ifeq ($(PHOENIX),true)
PHOENIX_TASKS        = phoenix-assets-build phoenix-digest
endif

all: info release postinfo

info:
	@echo "Build app release ..."

postinfo:
	@echo "... finished!"

release: $(RELEASE_FILE)

$(RELEASE_FILE): app-compile phoenix-assets
	$(IN_APP_DIR) mix release --env=$(MIX_ENV)

app-compile: app-deps
	$(IN_APP_DIR) MIX_ENV=$(MIX_ENV) mix compile

app-deps:
	$(IN_APP_DIR) mix deps.get

phoenix-assets: $(PHOENIX_TASKS)

phoenix-digest:
	$(IN_APP_DIR) MIX_ENV=$(MIX_ENV) mix $(DIGEST)

phoenix-assets-build: phoenix-node-modules
ifeq ($(HAS_PACKAGE_JSON),true)
	$(IN_ASSETS_DIR) $(NPM_DEPLOY_CMD)
else
	@echo No package.json found. Skipping assets building.
endif

phoenix-node-modules:
ifeq ($(HAS_PACKAGE_JSON),true)
	$(IN_ASSETS_DIR) $(NPM_INSTALL_CMD)
else
	@echo No package.json found. Skipping npm package installation.
endif

.PHONY: all app-compile app-deps info phoenix-assets phoenix-brunch-build phoenix-digest phoenix-node-modules postinfo release
