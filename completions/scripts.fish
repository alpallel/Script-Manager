# Disable file completion for subcommands
complete -c scripts -f -n "__fish_use_subcommand"

# Built-in subcommands
complete -c scripts -n "__fish_use_subcommand" -a update -d "Ensure all scripts are executable"
complete -c scripts -n "__fish_use_subcommand" -a new -d "Create a new script template"
complete -c scripts -n "__fish_use_subcommand" -a edit -d "Edit a script in your editor"
complete -c scripts -n "__fish_use_subcommand" -a path -d "Print path to a script"
complete -c scripts -n "__fish_use_subcommand" -a help -d "Show usage instructions"

# Custom scripts with individual descriptions
complete -c scripts -n "__fish_use_subcommand" -a "(scripts --list-completions-with-desc 2>/dev/null)"

# Complete script names for edit and path commands
complete -c scripts -n "__fish_seen_subcommand_from edit path" -a "(scripts --list-completions 2>/dev/null)" -d "Script"

# Enable file completion for subsequent arguments to custom scripts
complete -c scripts -n "not __fish_use_subcommand; and not __fish_seen_subcommand_from edit path new" -F