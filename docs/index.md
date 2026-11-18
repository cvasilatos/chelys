---
hide: [navigation, toc]
---

# :turtle: chelys

**Your shell, carried to every machine.**

One command gives any macOS or Linux machine the same zsh setup: the same prompt, plugins, fuzzy finder and tmux config — and it replaces whatever was there before, safely.

```bash
git clone https://github.com/cvasilatos/chelys.git ~/chelys && bash ~/chelys/install.sh
```

[Get started](getting-started.md){ .md-button .md-button--primary }
[See what you get](features.md){ .md-button }

---

<div class="grid cards" markdown>

-   :material-laptop:{ .lg } **macOS and Linux**

    Same script everywhere. Installs Homebrew on a Mac and uses apt, dnf, yum, pacman, zypper or apk on Linux.

-   :material-shield-check:{ .lg } **Nothing is lost**

    Any previous zsh setup is moved to `~/.zsh-old-setup.<timestamp>`, never deleted. Personal settings are carried over.

-   :material-account-lock-open:{ .lg } **No root needed**

    oh-my-zsh, plugins, fzf and oh-my-posh all install into your home folder. `sudo` is only used if zsh, git or curl are missing.

-   :material-sync:{ .lg } **One source of truth**

    `~/.zshrc` links into the repo. Change it once, `git pull` everywhere.

</div>

!!! quote "Why *chelys*?"
    *Chelys* (χέλυς) is Greek for tortoise shell. In the myth, the infant Hermes found a tortoise, and turned its shell into the first lyre — a plain shell made into an instrument.
