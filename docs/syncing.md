# Keeping machines in sync

`~/.zshrc` and `~/.tmux.conf` are links into the repo, so every machine is always running whatever is in its copy of `~/chelys`.

## Workflow

1. Change something on any machine, in `~/chelys`.
2. Commit and push:

    ```bash
    cd ~/chelys
    git commit -am "Add kubectl plugin"
    git push
    ```

3. On every other machine:

    ```bash
    git -C ~/chelys pull && exec zsh
    ```

## When do I need to re-run `install.sh`?

| What changed | What to run |
| --- | --- |
| `zshrc`, `tmux.conf` | `git pull`, then `exec zsh` (and `tmux source ~/.tmux.conf` inside tmux) |
| `blue-owl.omp.json` | `git pull`, then `cp ~/chelys/blue-owl.omp.json ~/.cache/oh-my-posh/themes/ && exec zsh` |
| `install.sh` (new plugin, new tool) | `git pull`, then `bash ~/chelys/install.sh` |

## Updating oh-my-zsh, plugins, fzf and oh-my-posh

Re-running `install.sh` downloads the latest version of everything. Or update pieces individually:

```bash
omz update                       # oh-my-zsh
git -C ~/.fzf pull && ~/.fzf/install --bin   # fzf
oh-my-posh upgrade               # oh-my-posh
```
