# Uninstall

## Go back to your previous setup

Each install moved the old setup to a backup folder. To restore the most recent one:

```bash
BK=$(ls -d ~/.zsh-old-setup.* | tail -1)
rm -f ~/.zshrc ~/.tmux.conf
rm -rf ~/.oh-my-zsh ~/.fzf
cp -a "$BK"/. ~/
exec zsh
```

!!! warning
    If you've installed more than once, the most recent backup is the setup that was there just before the **last** install — which may itself have been chelys. Look inside the folders (`ls -A ~/.zsh-old-setup.*`) to pick the one you want.

## Remove everything

```bash
rm -f ~/.zshrc ~/.tmux.conf ~/.zshrc.local ~/.zcompdump*
rm -rf ~/.oh-my-zsh ~/.fzf ~/.cache/oh-my-posh ~/.local/bin/oh-my-posh
rm -rf ~/chelys
```

If the installer added a `# chelys: start zsh` block to `~/.bashrc`, delete those lines. To go back to bash as your login shell:

```bash
chsh -s /bin/bash
```

## Clean up old backups

Once you're happy with the new setup:

```bash
rm -rf ~/.zsh-old-setup.*
```
