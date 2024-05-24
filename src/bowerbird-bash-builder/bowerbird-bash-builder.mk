define bowerbird::build-bash-executable
	@test -n "$^" || (echo "ERROR: no input files" && exit 1)
	@echo 'INFO: Bulding executable $@...'
	@mkdir -p $(dir $@)
	@echo '#!/usr/bin/env bash\n' > $@
	@cat $^ >> $@
	@echo >> $@
	@echo 'if [[ $${BASH_SOURCE[0]} == $${0} ]]; then' >> $@
	@echo '    ('  >> $@
	@echo '        set -euo pipefail'  >> $@
	@echo '        $(strip $(1)) "$$@"'  >> $@
    @echo '    )'  >> $@
	@echo 'fi'  >> $@
	@echo 'INFO: Bulding executable $@ completed.'
	@chmod u+x $@
endef

define bowerbird::build-bash-library
	@test -n "$^" || (echo "ERROR: no input files" && exit 1)
	@echo 'INFO: Bulding library $@...'
	@mkdir -p $(dir $@)
	@cat $^ > $@
	@echo 'INFO: Bulding library $@ completed.'
endef
