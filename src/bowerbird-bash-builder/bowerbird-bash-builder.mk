# bowerbird::build-bash-executable,<command>
#
#	Recipe for creating executable bash scripts. The target executable name is defined
#	using the $@ variable, and the source scripts are defined using  the prerequisite
#	$^ list variable. This command will concatenate the list of prerequisites together,
#	insert a bash shebang header, and add boilerplate code for executing a predefined
#	command when the the file is called directly.
#
#	Args:
#		command: Command to execute when the script is called directly.
#		$@: Target location for the executable.
#       $^: List of source files.
#
#	Example:
#		bash-executable: <source-file-1> ... <source-files-2>
#			$(call build-bash-executable,main)
#
#		-------------------------------------------------
#		#!/usr/bin/env bash
#
#		<source-file-1>
#		...
#		<source-file-n>
#
#		if [[ $${BASH_SOURCE[0]} == $${0} ]]; then
#	    	(
#        		set -euo pipefail
#        		<command>
#    		)
#		fi
#		-------------------------------------------------
#
define bowerbird::build-bash-executable
	@test -n "$^" || (echo "ERROR: no input files" && exit 1)
	@echo 'INFO: Bulding executable $@...'
	@mkdir -p $(dir $@)
	@echo '#!/usr/bin/env bash' > $@
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

# bowerbird::build-bash-library
#
#	Recipe for creating bash libraries. The target library file is defined using the
#	$@ variable, and the source scripts are defined using the prerequisite $^ list
#	variable. This command will concatenate the list of prerequisites together
#
#	Args:
#		$@: Target location for the library.
#       $^: List of source files.
#
#	Example:
#		bash-library: <source-file-1> ... <source-files-2>
#			$(call build-bash-library)
#
#		-------------------------------------------------
#		<source-file-1>
#		...
#		<source-file-n>
#		-------------------------------------------------
#
define bowerbird::build-bash-library
	@test -n "$^" || (echo "ERROR: no input files" && exit 1)
	@echo 'INFO: Bulding library $@...'
	@mkdir -p $(dir $@)
	@cat $^ > $@
	@echo 'INFO: Bulding library $@ completed.'
endef
