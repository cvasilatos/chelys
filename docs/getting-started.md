# Getting started

## Requirements

Nothing, really. The installer needs `zsh`, `git` and `curl`, and installs whichever are missing:

=== "macOS"

    If Homebrew isn't installed, the installer installs it first. That also brings Apple's command-line tools (and `git`). You'll be asked for your Mac password once.

=== "Linux"

    Missing packages are installed with the system package manager (apt, dnf, yum, pacman, zypper or apk) using `sudo`.
    If all three are already present — as on most servers — `sudo` is never used.

    No `sudo` and something missing? The installer stops and tells you what to ask an admin for.

## Install

```bash
git clone https://github.com/cvasilatos/chelys.git ~/chelys
bash ~/chelys/install.sh
```

Then **log out and back in**, or run:

```bash
exec zsh -l
```

!!! warning "Keep the folder"
    `~/.zshrc` and `~/.tmux.conf` become links into the cloned folder. If you move or delete it, your shell loses its config.
    To move it, move the folder and run `install.sh` again from the new place.

## Install on a remote server in one go

From your own machine:

```bash
ssh myserver 'git clone https://github.com/cvasilatos/chelys.git ~/chelys && bash ~/chelys/install.sh'
```

## Set the terminal font

The prompt uses icons from a [Nerd Font](https://www.nerdfonts.com/). The font belongs on the computer you **type on**, not on the servers you connect to.

=== "macOS"

    The installer already installed **Meslo Nerd Font**. In your terminal's settings, set the font to **MesloLGM Nerd Font**:

    - **Terminal.app:** Settings → Profiles → Text → Font
    - **iTerm2:** Settings → Profiles → Text → Font
    - **VS Code:** set `"terminal.integrated.fontFamily": "MesloLGM Nerd Font"`

=== "Linux desktop"

    ```bash
    ~/.local/bin/oh-my-posh font install Meslo
    ```

    Then pick **MesloLGM Nerd Font** in your terminal's settings.

=== "Windows (connecting to servers)"

    Download Meslo from [nerdfonts.com](https://www.nerdfonts.com/font-downloads), install it, and select it in Windows Terminal → Settings → Profile → Appearance.

If icons show up as boxes or question marks, the font is the cause.

## Running it again

The installer is safe to run as often as you like. Each run starts fresh: the current setup is moved to a new backup folder and everything is reinstalled from the repo.
