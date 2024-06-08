---
title: "How to make Homebrew-installed Bash your default shell"
date: "2022-12-19T13:38:43+00:00"
tags: ["Homebrew", "Bash"]
---

I realised today that despite having installed a modern version of Bash (via
`brew install bash`), I was still running Bash v3.2.57---the system version of
MacOS---as my default login shell.

```sh
$ bash --version
GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin21)
Copyright (C) 2007 Free Software Foundation, Inc.
```

This is because there are some post-installation steps that need to be followed,
and these aren't mentioned in the [Homebrew formulae notes][brew_formulae].

Specifically you need to allow-list the Homebrew-installed version so it can be
used as a login shell by adding the path to `/etc/shells`:

```sh
echo $(brew --prefix)/bin/bash | sudo tee -a /etc/shells
```

Then configure MacOS to use the Homebrew Bash as your user's default login
shell:

```sh
chsh -s $(brew --prefix)/bin/bash
```

It's also possible to change a user's default login shell from the "Users and
Groups" section of system preferences. To do this, CTRL-click on your user and
use the "advanced options" pop-up.

Verify this has worked by starting a new shell session and running:

```sh
echo $BASH_VERSION
5.2.12(1)-release
```

## Autocomplete woes

This was a yak-shave TIL shaken out of debugging why Git autocomplete wasn't
working. As part of the investigation, I realised the [`bash-completion@2`
Homebrew package][brew_formulae_completion] script wasn't sourcing each
package's autocomplete files as [the Bash version test][bash_test] wasn't
passing.

As it turns out, upgrading Bash and getting `bash-completion@2` to work didn't
fix the Git issue as the root cause was a [incompatibility between `hub` and
modern Git versions][hub_bug].

[brew_formulae]: https://formulae.brew.sh/formula/bash
[brew_formulae_completion]: https://formulae.brew.sh/formula/bash-completion@2
[hub_bug]: https://formulae.brew.sh/formula/bash-completion@2
[bash_test]:
  https://github.com/scop/bash-completion/blob/master/bash_completion.sh.in#L5-L7
