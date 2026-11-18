# What you get

## The prompt

The prompt is [oh-my-posh](https://ohmyposh.dev) with the **blue-owl** theme.

| Left side | Right side |
| --- | --- |
| ⚡ when you're root | Active Python virtualenv |
| OS icon | `user / host` |
| Current folder | Clock |
| Git branch, staged and changed files, stash count | |
| How long the last command took | |
| Exit status, in words, when a command fails (e.g. `SIGINT` after <kbd>Ctrl</kbd>+<kbd>C</kbd>) | |
| `❯`, red if the last command failed | |

## zsh plugins

| Plugin | What it does |
| --- | --- |
| **zsh-autosuggestions** | Shows a greyed-out suggestion from your history. <kbd>→</kbd> accepts it. |
| **zsh-syntax-highlighting** | Commands turn green if they exist and red if they don't — before you press Enter. |
| **zsh-history-substring-search** | Type part of a command, then <kbd>↑</kbd>/<kbd>↓</kbd> to cycle through matching history. |
| **fzf-tab** | Replaces zsh's tab-completion menu with an fzf fuzzy picker. |
| `git` | Short aliases: `gst` (status), `gco` (checkout), `gp` (push), `gl` (pull), [and many more](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git). |
| `docker`, `docker-compose` | Completions and aliases (`dps`, `dco`, …). |
| `python` | `py` alias, `pyclean`, virtualenv helpers. |
| `sudo` | Press <kbd>Esc</kbd> <kbd>Esc</kbd> to put `sudo` in front of the current (or last) command. |
| `history` | `h` shows history, `hs` searches it. |

## fzf shortcuts

| Keys | What it does |
| --- | --- |
| <kbd>Ctrl</kbd>+<kbd>R</kbd> | Fuzzy-search your command history |
| <kbd>Ctrl</kbd>+<kbd>T</kbd> | Pick files and paste their paths |
| <kbd>Alt</kbd>+<kbd>C</kbd> | Jump into a sub-directory |
| `**`<kbd>Tab</kbd> | Fuzzy completion, e.g. `vim **`<kbd>Tab</kbd> or `ssh **`<kbd>Tab</kbd> |

!!! tip "macOS: Alt key"
    On a Mac, <kbd>Alt</kbd>+<kbd>C</kbd> needs *Option as Meta*: in Terminal.app, Settings → Profiles → Keyboard → **Use Option as Meta key**; in iTerm2, Profiles → Keys → Left Option key → **Esc+**.

## tmux

| Setting | Effect |
| --- | --- |
| zsh as the shell | Found wherever it's installed (`/usr/bin/zsh` on Linux, `/bin/zsh` on macOS) |
| `mouse on` | Click to select panes, scroll with the wheel, drag to resize |
| 256 colours | The prompt looks the same inside tmux |
| <kbd>Ctrl</kbd>+<kbd>K</kbd> | Clears the screen **and** the scrollback |
