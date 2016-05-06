include edib/shared.mk

SSH_KEYS_SRC  = $(HOME)/ssh
SSH_KEYS_DEST = $(HOME)/.ssh

all: move-app copy-ssh-keys

move-app: $(APP_DIR)

$(APP_DIR):
	rsync -av \
		--exclude=.git\
		--exclude=.edib.log \
		--exclude=_build \
		--exclude=deps \
		--exclude=node_modules \
		--exclude=rel/$(APP_NAME) \
		--exclude=tarballs \
		$(SOURCE_DIR)/ $(APP_DIR)

copy-ssh-keys: $(SSH_KEYS_DEST)

$(SSH_KEYS_DEST):
	if [ -d $(SSH_KEYS_SRC) ]; then \
		mkdir $(SSH_KEYS_DEST) && \
		rsync -av --no-owner $(SSH_KEYS_SRC)/ $(SSH_KEYS_DEST); \
	fi
