<h1 align="center">🐢 chelys</h1>

<p align="center">
  <b>Your shell, carried to every machine.</b><br>
  One command gives any macOS or Linux machine the same zsh setup — prompt, plugins, fzf and tmux included.
</p>

<p align="center">
  <a href="https://cvasilatos.github.io/chelys/"><img alt="Docs" src="https://img.shields.io/badge/docs-cvasilatos.github.io%2Fchelys-0b7285"></a>
  <a href="https://github.com/cvasilatos/chelys/actions/workflows/docs.yml"><img alt="Docs build" src="https://github.com/cvasilatos/chelys/actions/workflows/docs.yml/badge.svg"></a>
  <img alt="Platforms" src="https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey">
</p>

> *Chelys* (χέλυς) is Greek for tortoise shell. In the myth, Hermes turned one into the first lyre —
> a plain shell made into an instrument. This repo does the same for your terminal.

---

## Install

```bash
git clone https://github.com/cvasilatos/chelys.git ~/chelys
bash ~/chelys/install.sh
```

Then log out and back in (or run `exec zsh -l`).

That's it. The installer works on **macOS** and on **Linux** (apt, dnf, yum, pacman, zypper, apk), installs anything that's missing, and needs no further input.

> [!IMPORTANT]
> Keep the cloned folder. `~/.zshrc` and `~/.tmux.conf` become links into it, so moving or deleting it breaks your shell.
> If you move it, run `install.sh` again from the new location.

## What you get

| Piece | What it does |
| --- | --- |
| **zsh + [oh-my-zsh](https://ohmyz.sh)** | The shell and its plugin framework |
| **[oh-my-posh](https://ohmyposh.dev)** with the *blue-owl* theme | The prompt: path, git status, run time, exit status, Python venv, user/host, clock |
| **zsh-autosuggestions** | Suggests commands from your history as you type (→ to accept) |
| **zsh-syntax-highlighting** | Colours commands green/red before you run them |
| **zsh-history-substring-search** | ↑/↓ search history for what you've already typed |
| **[fzf](https://github.com/junegunn/fzf)** + **fzf-tab** | Fuzzy finder: <kbd>Ctrl</kbd>+<kbd>R</kbd> history, <kbd>Ctrl</kbd>+<kbd>T</kbd> files, <kbd>Alt</kbd>+<kbd>C</kbd> directories, fuzzy tab completion |
| oh-my-zsh plugins | `git`, `docker`, `docker-compose`, `python`, `sudo` (<kbd>Esc</kbd> <kbd>Esc</kbd> adds sudo), `history` |
| **tmux** config | Mouse support, 256 colours, zsh as the shell, <kbd>Ctrl</kbd>+<kbd>K</kbd> clears screen and scrollback |

## Updating every machine

Change things in the repo, push, then on each machine:

```bash
git -C ~/chelys pull
exec zsh
```

Because `~/.zshrc` is a link into the repo, a pull is all it takes. Re-run `install.sh` only when the installer itself changed.

## Per-machine settings

Anything that should only apply to one machine — or that is private, like API keys, work paths or server names — goes in `~/.zshrc.local`. That file lives in your home folder, **outside the repo**, so it is never committed or shared. It's loaded last, so it can override anything. Start from the template:

```bash
cp ~/chelys/zshrc.local.example ~/.zshrc.local
```

For example:

```zsh
# ~/.zshrc.local
export PATH="/opt/cuda/bin:$PATH"
alias gpu='watch -n1 nvidia-smi'
```

## Replacing an existing setup

The installer **replaces** whatever zsh setup a machine already has — oh-my-zsh, prezto, zinit, antigen, zplug, zim, powerlevel10k, starship. Nothing is deleted: it's all moved to `~/.zsh-old-setup.<timestamp>`.
Personal lines from an old `.zprofile` / `.zshenv` (PATH changes, conda, pyenv…) are copied into `~/.zshrc.local` for you. `~/.zfunc` (your own completions) is left in place.

## Documentation

Full docs, including troubleshooting and how each step works: **https://cvasilatos.github.io/chelys/**

## Repository layout

```
chelys/
├── install.sh          # the installer
├── zshrc               # linked to ~/.zshrc
├── tmux.conf           # linked to ~/.tmux.conf
├── blue-owl.omp.json   # the prompt theme
├── zshrc.local.example # template for private, per-machine settings
├── docs/               # documentation website (MkDocs)
└── mkdocs.yml
```
