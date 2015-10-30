# app release builder

include edib/shared.mk

EXRM     = $(shell $(APPINFO_RUNNER) exrm)
EXRM_ERR = The project as no 'exrm' dependency. Cannot proceed further

all: exrm

exrm:
ifneq ($(EXRM),true)
	$(error $(EXRM_ERR))
else
	@echo exrm depenceny is present.
endif

.PHONY: all exrm
