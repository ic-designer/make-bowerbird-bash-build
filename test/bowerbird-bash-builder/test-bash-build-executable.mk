# Targets
test-build-bash-executable-no-files:
	! $(MAKE) -q $(WORKDIR_TEST)/test-build-bash-executable-no-files/executable.sh

$(WORKDIR_TEST)/test-build-bash-executable-no-files/executable.sh:
	$(bowerbird::build-bash-executable)


test-build-bash-executable-one-file: \
		$(WORKDIR_TEST)/test-build-bash-executable-one-file/executable.sh
	test "alpha" = "$(shell $^)"
	test "alpha beta" = "$(shell $^ beta)"
	test "alpha beta gamma" = "$(shell $^ beta gamma)"

$(WORKDIR_TEST)/test-build-bash-executable-one-file/executable.sh: \
		$(WORKDIR_TEST)/test-build-bash-executable-one-file/alpha-src.sh
	$(call bowerbird::build-bash-executable, alpha)


test-build-bash-executable-two-files: \
		$(WORKDIR_TEST)/test-build-bash-executable-two-files/executable.sh
	test "alpha beta" = "$(shell $^)"
	test "alpha gamma beta gamma" = "$(shell $^ gamma)"
	test "alpha gamma delta beta gamma delta" = "$(shell $^ gamma delta)"

$(WORKDIR_TEST)/test-build-bash-executable-two-files/executable.sh: \
		$(WORKDIR_TEST)/test-build-bash-executable-one-file/alpha-src.sh \
		$(WORKDIR_TEST)/test-build-bash-executable-one-file/beta-src.sh
	$(call bowerbird::build-bash-executable, alpha "$$@" beta)


$(WORKDIR_TEST)/%-src.sh: $(MAKEFILE_LIST)
	mkdir -p $(dir $)
	echo 'function $(notdir $*) () { echo $(notdir $*) $$@; }' > $@
