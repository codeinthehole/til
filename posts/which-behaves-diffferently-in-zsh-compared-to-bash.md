---
title: "`which` behaves diffferently in Zsh compared to Bash"
date: "2022-09-29T19:21:45+01:00"
tags: ["Bash", "Zsh", "Unix"]
---

`which` is a command used to identify the location of executables; however it
behaves differently on Zsh compared to Bash.

In Bash, `which` is an executable file, normally found in `/usr/bin/which`. It
has a `man` page like other commands.

In Zsh, `which` is an alias of the `whence` builtin. From `man zshbuiltins`:

```txt
whence [ -vcwfpamsS ] [ -x num ] name ...
       For each name, indicate how it would be interpreted if used as a
       command name.

       If name is not an alias, built-in command, external command, shell
       function, hashed command, or a reserved word, the exit status
       shall be non-zero, and -- if -v, -c, or -w was passed -- a message
       will be written to standard output.  (This is different from other
       shells that write that message to standard error.)

       ...

       -c     Print the results in a csh-like format.  This takes
              precedence over -v.
       ...

which [ -wpamsS ] [ -x num ] name ...
       Equivalent to whence -c.
```

## What difference does it make?

A notable difference is that, in Zsh, if the passed name is a shell function,
`which` will print its implementation.

## Pyenv example

This is apparent with `pyenv` which declares a shell function called `pyenv`
when its `init` function is called:

```sh
eval "$(pyenv init -)"
```

In Bash, `which` shows the location where Homebrew has installed it:

```sh
$ which pyenv
/usr/local/bin/pyenv
```

But in Zsh we see its function implementation:

```sh
pyenv () {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]
    then
        shift
    fi
    case "$command" in
        (rehash | shell | virtualenvwrapper | virtualenvwrapper_lazy) eval "$(pyenv "sh-$command" "$@")" ;;
        (*) command pyenv "$command" "$@" ;;
    esac
}
```

This caught us out in trying to write Python upgrade instructions that worked in
both Bash and Zsh.
