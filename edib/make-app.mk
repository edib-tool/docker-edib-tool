# app release builder

include edib/shared.mk

IN_APP_DIR           = cd $(APP_DIR) &&
PHOENIX              = $(shell $(APPINFO_RUNNER) phoenix)
ifeq ($(PHOENIX),true)
PHOENIX_TASKS        = phoenix-brunch-build phoenix-digest
endif
PHOENIX_PACKAGE_JSON = $(APP_DIR)/package.json
PHOENIX_BRUNCH_CFG   = $(APP_DIR)/brunch-config.js
HAS_PACKAGE_JSON     = $(shell [ -f $(PHOENIX_PACKAGE_JSON) ] && echo true)
HAS_BRUNCH_CFG       = $(shell [ -f $(PHOENIX_BRUNCH_CFG) ] && echo true)
NPM_INSTALL_CMD      = npm install
NODE_MODULES         = $(APP_DIR)/node_modules
NODE_BIN_DIR         = $(NODE_MODULES)/.bin
PHOENIX_BRUNCH_CMD   = $(NODE_BIN_DIR)/brunch build

all: info release postinfo

info:
	@echo "Build app release ..."

postinfo:
	@echo "... finished!"

release: $(RELEASE_FILE)

$(RELEASE_FILE): app-compile phoenix-assets
	$(IN_APP_DIR) mix release --env=prod

app-compile: app-deps
	$(IN_APP_DIR) MIX_ENV=$(MIX_ENV) mix compile

app-deps:
	$(IN_APP_DIR) mix deps.get

phoenix-assets: $(PHOENIX_TASKS)

phoenix-digest:
	$(IN_APP_DIR) MIX_ENV=$(MIX_ENV) mix phoenix.digest

phoenix-brunch-build: phoenix-node-modules
ifeq ($(HAS_BRUNCH_CFG),true)
	$(IN_APP_DIR) $(PHOENIX_BRUNCH_CMD)
else
	@echo No brunch config found. Skipping brunch build task.
	@echo "(If you use another asset build tool, let me know.)"
endif

phoenix-node-modules:
ifeq ($(HAS_PACKAGE_JSON),true)
	$(IN_APP_DIR) $(NPM_INSTALL_CMD)
else
	@echo No package.json found. Skipping npm package installation.
endif

.PHONY: all app-compile app-deps info phoenix-assets phoenix-brunch-build phoenix-digest phoenix-node-modules postinfo release
