_scripts_completions() {
    local cur prev
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    if [[ $COMP_CWORD -eq 1 ]]; then
        # Preserve array order so custom scripts appear before built-in commands
        compopt -o nosort 2>/dev/null || true

        local builtins="refresh update add new edit path which uninstall help -h --help"
        local scripts
        scripts="$(scripts --list-completions 2>/dev/null)"

        local script_matches=()
        local builtin_matches=()
        if [[ -n "$scripts" ]]; then
            mapfile -t script_matches < <(compgen -W "$scripts" -- "$cur")
        fi
        mapfile -t builtin_matches < <(compgen -W "$builtins" -- "$cur")

        # Custom scripts first, then built-in commands
        COMPREPLY=( "${script_matches[@]}" "${builtin_matches[@]}" )
    elif [[ $COMP_CWORD -eq 2 && ( "$prev" == "edit" || "$prev" == "path" || "$prev" == "which" ) ]]; then
        local scripts
        scripts="$(scripts --list-completions 2>/dev/null)"
        mapfile -t COMPREPLY < <(compgen -W "$scripts" -- "$cur")
    fi
}

complete -F _scripts_completions -o default scripts
