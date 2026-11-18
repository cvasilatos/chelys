# Troubleshooting

## Icons show as boxes or question marks

Your terminal isn't using a Nerd Font. See [Set the terminal font](getting-started.md#set-the-terminal-font). Remember: the font goes on the computer you type on, not on the server.

## The cursor sits on top of the space after `❯`

zsh is measuring the prompt icons wrong, which happens when the machine isn't using a UTF-8 locale. `zshrc` fixes this automatically. Check with:

```bash
locale charmap      # should print UTF-8
```

If it doesn't, see which UTF-8 locales exist (`locale -a | grep -i utf`) and set one in `~/.zshrc.local`, e.g. `export LANG=en_US.UTF-8`.

## `_omp_preexec: no such file or directory: /opt/homebrew/bin/oh-my-posh`

oh-my-posh's cached setup still points to an old copy (here, a Homebrew one that's been removed). Note *which* machine prints it — if it appears right after you type `ssh server`, it's coming from your local machine. Fix it there:

```bash
rm -f ~/.cache/oh-my-posh/init.* ~/.cache/oh-my-posh/*omp.cache && exec zsh
```

## The first prompt says `ERROR`

Something in your startup files ended with a non-zero exit status. The status segment shows the exit code of the *last* command, and at login that's the last line of your startup files. Look at the end of `~/.zshrc.local`: a line like `[ -f file ] && source file` fails when the file is missing. Write it as an `if` instead:

```zsh
if [ -f file ]; then source file; fi
```

## `SIGINT` in the prompt

Not a problem: it means the last command was stopped with <kbd>Ctrl</kbd>+<kbd>C</kbd>.

## I still get bash after logging in

Your account probably can't change its own login shell (common for LDAP/domain accounts). The installer then adds a block to `~/.bashrc` that starts zsh. Check it's there:

```bash
grep -n zsh ~/.bashrc
```

If your login reads `~/.bash_profile` but that file doesn't load `~/.bashrc`, add this to `~/.bash_profile`:

```bash
[ -f ~/.bashrc ] && . ~/.bashrc
```

## `brew: command not found` on a Mac

Homebrew is loaded by `zshrc`. Make sure `~/.zshrc` is the link into the repo (`ls -l ~/.zshrc`) and open a new terminal.

## A setting from my old setup is gone

Everything old is in `~/.zsh-old-setup.<timestamp>`. Copy what you need into `~/.zshrc.local`:

```bash
ls -d ~/.zsh-old-setup.*
less ~/.zsh-old-setup.*/.zshrc
```

## tmux doesn't pick up changes

```bash
tmux source ~/.tmux.conf
```

Some settings (like the default shell) only affect new windows.
