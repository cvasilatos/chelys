# Customizing

There are two places to change things, depending on whether the change is for **every machine** or **just one**.

## Every machine: edit the repo

| To change | Edit |
| --- | --- |
| Shell settings, aliases, plugins | `zshrc` |
| The prompt | `blue-owl.omp.json` |
| tmux | `tmux.conf` |

Commit, push, then [sync the other machines](syncing.md).

### Add an oh-my-zsh plugin

Bundled plugins ([full list](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)) just need their name added to the `plugins=(...)` line in `zshrc`:

```zsh
plugins=(git docker docker-compose python sudo history kubectl fzf-tab zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)
```

!!! note "Order matters"
    Keep `zsh-syntax-highlighting` and `zsh-history-substring-search` at the end — they need to load after everything else.

Third-party plugins also need to be downloaded. Add the GitHub `owner/name` to the list in step 2 of `install.sh`:

```bash
for r in zsh-users/zsh-autosuggestions ... Aloxaf/fzf-tab you/your-plugin; do
```

### Change the prompt

The prompt is defined in `blue-owl.omp.json`. Browse other looks in the [oh-my-posh theme gallery](https://ohmyposh.dev/docs/themes), or edit segments as described in the [oh-my-posh docs](https://ohmyposh.dev/docs/configuration/general).

To try a change without reinstalling:

```bash
cp ~/chelys/blue-owl.omp.json ~/.cache/oh-my-posh/themes/ && exec zsh
```

## One machine: `~/.zshrc.local`

`~/.zshrc.local` is loaded at the very end of `zshrc`, so it can add to or override anything. It lives in your home folder, **outside the repo**, so each machine keeps its own and nothing in it is ever committed.

!!! danger "Keep private things out of the repo"
    The repo is public. API keys, tokens, work paths, server or project names belong in `~/.zshrc.local`, never in `zshrc`. The repo's `.gitignore` also blocks `*.local`, `.env` and key files as a safety net.

Start from the template:

```bash
cp ~/chelys/zshrc.local.example ~/.zshrc.local
```

```zsh
# ~/.zshrc.local  (example for a GPU server)
export PATH="/usr/local/cuda/bin:$PATH"
export CUDA_VISIBLE_DEVICES=0
alias gpu='watch -n1 nvidia-smi'

# conda
[ -f ~/miniconda3/etc/profile.d/conda.sh ] && source ~/miniconda3/etc/profile.d/conda.sh
```

When the installer replaces an old setup, it creates this file for you from the personal lines in the old `.zprofile` and `.zshenv`.

## Your own tab completions

Put completion files (named `_command`) in `~/.zfunc`. That folder is on zsh's completion path and the installer never touches it.
