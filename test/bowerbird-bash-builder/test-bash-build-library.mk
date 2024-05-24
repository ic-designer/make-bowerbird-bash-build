# Constants
override TEST_FILE.MK := $(lastword $(MAKEFILE_LIST))

# Targets
PHONY: test-bash-build-library
test-bash-build-library: \
		test-build-bash-library-no-files \
		test-build-bash-library-one-file \
		test-build-bash-library-two-files \


PHONY: test-build-bash-library-no-files
test-build-bash-library-no-files:
	@! $(MAKE) -q $(WORKDIR_TEST)/test-build-bash-library-no-files/library.sh
	@printf "\e[1;32mPassed: $(TEST_FILE.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-library-no-files/library.sh:
	$(bowerbird::build-bash-library)


PHONY: test-build-bash-library-one-file
test-build-bash-library-one-file: \
		$(WORKDIR_TEST)/test-build-bash-library-one-file/library-actual.sh \
		$(WORKDIR_TEST)/test-build-bash-library-one-file/library-expected.sh
	@diff -y $^
	@printf "\e[1;32mPassed: $(TEST_FILE.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-library-one-file/library-actual.sh: \
		$(WORKDIR_TEST)/test-build-bash-library-one-file/alpha-src.sh
	@$(bowerbird::build-bash-library)

$(WORKDIR_TEST)/test-build-bash-library-one-file/library-expected.sh:
	@mkdir -p $(dir $@)
	@echo 'function alpha () { echo alpha "$$@"; }' > $@


PHONY: test-build-bash-library-two-files
test-build-bash-library-two-files: \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/library-actual.sh \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/library-expected.sh
	@diff -y $^
	@printf "\e[1;32mPassed: $(TEST_FILE.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-library-two-files/library-actual.sh: \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/alpha-src.sh \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/beta-src.sh
	@$(bowerbird::build-bash-library)

$(WORKDIR_TEST)/test-build-bash-library-two-files/library-expected.sh:
	@mkdir -p $(dir $@)
	@echo 'function alpha () { echo alpha "$$@"; }' > $@
	@echo 'function beta () { echo beta "$$@"; }' >> $@


$(WORKDIR_TEST)/%-src.sh: $(MAKEFILE_LIST)
	@mkdir -p $(dir $@)
	@echo 'function $(notdir $*) () { echo $(notdir $*) "$$@"; }' > $@
