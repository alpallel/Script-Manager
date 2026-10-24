# shellcheck shell=bash
# shellcheck disable=all

# Reset any previous completions for scripts
complete -c scripts -e

# Disable file completion for subcommands
complete -c scripts -f -n "__fish_use_subcommand"

# 1. Built-in subcommands (registered first with -k)
complete -c scripts -k -n "__fish_use_subcommand" -a '(printf "%s\t%s\n" \
    "refresh" "Ensure all scripts in directory are executable" \
    "update" "Update Script-Manager to latest version" \
    "add" "Copy and add an external script" \
    "new" "Create a new script template" \
    "edit" "Edit a script in editor" \
    "path" "Print path to a script" \
    "uninstall" "Uninstall Script-Manager and shell completions" \
    "help" "Show usage instructions")'

# 2. Custom scripts (registered with -k after subcommands so custom scripts appear first in autocomplete)
complete -c scripts -k -n "__fish_use_subcommand" -a "(scripts --list-completions-with-desc 2>/dev/null)"

# Complete script names for edit and path commands
complete -c scripts -n "__fish_seen_subcommand_from edit path" -a "(scripts --list-completions 2>/dev/null)" -d "Script"

# Enable file completion for add command
complete -c scripts -n "__fish_seen_subcommand_from add" -F

# Enable file completion for subsequent arguments to custom scripts
complete -c scripts -n "not __fish_use_subcommand; and not __fish_seen_subcommand_from edit path new add" -F
