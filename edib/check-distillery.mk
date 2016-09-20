# app release builder

include edib/shared.mk

DISTILLERY     = $(shell $(APPINFO_RUNNER) distillery)
DISTILLERY_ERR = The project as no 'distillery' dependency. Cannot proceed further

all: distillery

distillery:
ifneq ($(DISTILLERY),true)
	$(error $(DISTILLERY_ERR))
else
	@echo distillery dependency is present.
endif

.PHONY: all distillery
