# Bowerbird Bash Builder

[![Makefile CI](https://github.com/ic-designer/make-bowerbird-bash-builder/actions/workflows/makefile.yml/badge.svg)](https://github.com/ic-designer/make-bowerbird-bash-builder/actions/workflows/makefile.yml)

## Installation

The Bowerbird Tools can be loaded using the Bowerbird Dependency Tools as shown
below. Please refer the [Bowerbird Depend Tools](https://github.com/ic-designer/make-bowerbird-deps.git)
for more information about the `bowerbird::git-dependency` macro.

```makefile
$(eval $(call bowerbird::git-dependency,$(WORKDIR_DEPS)/bowerbird-bash-builder,\
        https://github.com/ic-designer/make-bowerbird-bash-builder.git,main,bowerbird.mk))
```

## Macros

### `bowerbird::build-bash-executable`

```
bowerbird::build-bash-executable,<command>

    Recipe for creating executable bash scripts. The target executable name is defined
    using the $@ variable, and the source scripts are defined using  the prerequisite
    $^ list variable. This command will concatenate the list of prerequisites together,
    insert a bash shebang header, and add boilerplate code for executing a predefined
    command when the the file is called directly.

    Args:
        command: Command to execute when the script is called directly.
        $@: Target location for the executable.
      $^: List of source files.

    Example:
        bash-executable: <source-file-1> ... <source-files-2>
            $(call build-bash-executable,main)

        -------------------------------------------------
        #!/usr/bin/env bash

        <source-file-1>
        ...
        <source-file-n>

        if [[ $${BASH_SOURCE[0]} == $${0} ]]; then
            (
               set -euo pipefail
               <command>
           )
        fi
        -------------------------------------------------
```

### `bowerbird::build-bash-library`

```
bowerbird::build-bash-library

    Recipe for creating bash libraries. The target library file is defined using the
    $@ variable, and the source scripts are defined using the prerequisite $^ list
    variable. This command will concatenate the list of prerequisites together

    Args:
        $@: Target location for the library.
      $^: List of source files.

    Example:
        bash-library: <source-file-1> ... <source-files-2>
            $(call build-bash-library)

        -------------------------------------------------
        <source-file-1>
        ...
        <source-file-n>
        -------------------------------------------------
```
