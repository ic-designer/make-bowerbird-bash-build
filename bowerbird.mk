_PATH := $(dir $(lastword $(MAKEFILE_LIST)))
include $(_PATH)/src/bowerbird-bash-builder/bowerbird-bash-builder.mk
