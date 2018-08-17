#/usr/bin/env bash

_foo()
{
    local cur prev
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    case ${COMP_CWORD} in
        1)
		COMPREPLY=($(compgen -W "$(./photodb-completion.pl)" -- ${cur}))
            ;;
        2)
		COMPREPLY=($(compgen -W "$(./photodb-completion.pl ${prev})" -- ${cur}))
            ;;
        *)
            COMPREPLY=()
            ;;
    esac
}

complete -F _foo photodb
