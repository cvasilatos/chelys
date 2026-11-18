# How it works

`install.sh` runs these steps in order. It stops at the first error (`set -e`).

## 0. Prerequisites

Checks for `zsh`, `git` and `curl` and installs whichever are missing.

- **macOS:** installs Homebrew non-interactively if needed, then `brew install`.
- **Linux:** detects the package manager — apt, dnf, yum, pacman, zypper or apk — and installs with `sudo`. If you're root, `sudo` isn't used. If `sudo` isn't available, it stops with a message.

## 1. Move the old setup aside

These are moved into `~/.zsh-old-setup.<timestamp>`:

| Kind | Paths |
| --- | --- |
| Frameworks | `~/.oh-my-zsh`, `~/.zprezto`, `~/.zinit`, `~/.local/share/zinit`, `~/.antigen`, `~/.zplug`, `~/.zim` |
| Prompts | `~/.p10k.zsh`, `~/.cache/p10k-*`, `~/.config/starship.toml` |
| fzf | `~/.fzf`, `~/.fzf.zsh` |
| zsh startup files | `~/.zshrc`, `~/.zshenv`, `~/.zprofile`, `~/.zlogin`, `~/.zlogout`, `~/.zcompdump*` |
| tmux | `~/.tmux.conf` |

Links that already point into this repo are left alone. `~/.zfunc` is never moved.

If `~/.zshrc.local` doesn't exist yet, the lines from the old `.zshenv` and `.zprofile` are copied into it — except ones mentioning another framework, prompt, fzf or Homebrew, which the new setup handles itself.

## 2. oh-my-zsh and plugins

A fresh oh-my-zsh, plus four plugins cloned into `~/.oh-my-zsh/custom/plugins`.

## 3. fzf and oh-my-posh

- **fzf** is cloned to `~/.fzf` (binary in `~/.fzf/bin`). `zshrc` puts that first on `PATH`, so it wins over any older system copy.
- **oh-my-posh** goes into `~/.local/bin`.
- Old oh-my-posh cache files are deleted (they contain the path of whichever oh-my-posh created them).
- The theme is copied to `~/.cache/oh-my-posh/themes/`.
- On macOS, the Meslo Nerd Font is installed.

## 4. Link the configs

```
~/.zshrc      →  ~/chelys/zshrc
~/.tmux.conf  →  ~/chelys/tmux.conf
```

## 5. Make zsh the login shell

Tries `chsh`. On machines where that's not allowed — common for university or company (LDAP/domain) accounts — it adds a short block to `~/.bashrc` that switches to zsh when you log in. It doesn't add one if `.bashrc` already starts zsh.

## What `zshrc` does

In order:

1. **Switches to a UTF-8 locale** if the machine isn't using one. Without it, zsh counts each prompt icon as 3 characters wide and puts the cursor in the wrong place.
2. **Loads Homebrew** on macOS (because the old `.zprofile` that did it was moved aside).
3. Loads oh-my-zsh and its plugins.
4. Starts oh-my-posh and fzf.
5. Adds `~/.zfunc` to the completion path.
6. Loads `~/.zshrc.local` if it exists.
7. Ends with `true`, so your first prompt doesn't show a leftover `ERROR`.
