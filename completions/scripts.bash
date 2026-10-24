_scripts_completions() {
    local cur prev
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    if [[ $COMP_CWORD -eq 1 ]]; then
        local builtins="update add new edit path which help -h --help"
        local scripts
        scripts="$(scripts --list-completions 2>/dev/null)"
        mapfile -t COMPREPLY < <(compgen -W "$builtins $scripts" -- "$cur")
    elif [[ $COMP_CWORD -eq 2 && ( "$prev" == "edit" || "$prev" == "path" || "$prev" == "which" ) ]]; then
        local scripts
        scripts="$(scripts --list-completions 2>/dev/null)"
        mapfile -t COMPREPLY < <(compgen -W "$scripts" -- "$cur")
    fi
}

complete -F _scripts_completions -o default scripts
