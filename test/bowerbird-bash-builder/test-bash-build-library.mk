test-build-bash-library-no-files:
	! $(MAKE) -q $(WORKDIR_TEST)/test-build-bash-library-no-files/library.sh

$(WORKDIR_TEST)/test-build-bash-library-no-files/library.sh:
	$(bowerbird::build-bash-library)


test-build-bash-library-one-file: \
		$(WORKDIR_TEST)/test-build-bash-library-one-file/library-actual.sh \
		$(WORKDIR_TEST)/test-build-bash-library-one-file/library-expected.sh
	$(call bowerbird::test::compare-files,\
			$(WORKDIR_TEST)/$@/library-actual.sh,\
			$(WORKDIR_TEST)/$@/library-expected.sh)

$(WORKDIR_TEST)/test-build-bash-library-one-file/library-actual.sh: \
		$(WORKDIR_TEST)/test-build-bash-library-one-file/alpha-src.sh
	$(bowerbird::build-bash-library)

$(WORKDIR_TEST)/test-build-bash-library-one-file/library-expected.sh:
	mkdir -p $(dir $@)
	echo 'function alpha () { echo alpha $$@; }' > $@


test-build-bash-library-two-files: \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/library-actual.sh \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/library-expected.sh
	$(call bowerbird::test::compare-files,\
			$(WORKDIR_TEST)/$@/library-actual.sh,\
			$(WORKDIR_TEST)/$@/library-expected.sh)

$(WORKDIR_TEST)/test-build-bash-library-two-files/library-actual.sh: \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/alpha-src.sh \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/beta-src.sh
	$(bowerbird::build-bash-library)

$(WORKDIR_TEST)/test-build-bash-library-two-files/library-expected.sh:
	mkdir -p $(dir $@)
	echo 'function alpha () { echo alpha $$@; }' > $@
	echo 'function beta () { echo beta $$@; }' >> $@


$(WORKDIR_TEST)/%-src.sh: $(MAKEFILE_LIST)
	mkdir -p $(dir $@)
	echo 'function $(notdir $*) () { echo $(notdir $*) $$@; }' > $@
