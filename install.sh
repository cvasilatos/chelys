#!/usr/bin/env bash
# chelys - your shell, carried to every machine (macOS + Linux)
# Usage: bash install.sh
# Replaces any existing zsh setup with this one. The old setup is moved to
# ~/.zsh-old-setup.<timestamp>, not deleted.
set -e
DIR="$(cd "$(dirname "$0")" && pwd -P)"
OS="$(uname -s)"
say() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }

# sudo only if needed and available
if [ "$(id -u)" = 0 ]; then SUDO=""; elif command -v sudo >/dev/null; then SUDO="sudo"; else SUDO="none"; fi

# 0. Prerequisites: zsh, git, curl
missing=""; for c in zsh git curl; do command -v $c >/dev/null || missing="$missing $c"; done
if [ "$OS" = Darwin ]; then
  for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do [ -x $b ] && eval "$($b shellenv)" && break; done
  if ! command -v brew >/dev/null; then
    say "Installing Homebrew (also installs Apple's command-line tools / git; asks for your Mac password once)"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do [ -x $b ] && eval "$($b shellenv)" && break; done
  fi
  [ -n "$missing" ] && brew install $missing
elif [ -n "$missing" ]; then
  [ "$SUDO" = none ] && { echo "Missing:$missing and no sudo available - ask an admin to install them."; exit 1; }
  say "Installing:$missing"
  if   command -v apt-get >/dev/null; then $SUDO apt-get update -qq && $SUDO apt-get install -y -qq $missing
  elif command -v dnf     >/dev/null; then $SUDO dnf install -y -q $missing
  elif command -v yum     >/dev/null; then $SUDO yum install -y -q $missing
  elif command -v pacman  >/dev/null; then $SUDO pacman -Sy --noconfirm $missing
  elif command -v zypper  >/dev/null; then $SUDO zypper -q install -y $missing
  elif command -v apk     >/dev/null; then $SUDO apk add -q $missing
  else echo "Unknown package manager - install:$missing"; exit 1; fi
fi

# 1. Move any previous zsh setup out of the way
say "Moving old zsh setup aside"
BK="$HOME/.zsh-old-setup.$(date +%s)"; mkdir -p "$BK"
shopt -s nullglob
for f in ~/.oh-my-zsh ~/.zprezto ~/.zinit ~/.local/share/zinit ~/.antigen ~/.zplug ~/.zim \
         ~/.p10k.zsh ~/.cache/p10k-* ~/.config/starship.toml ~/.fzf ~/.fzf.zsh ~/.zcompdump* \
         ~/.zshrc ~/.zshenv ~/.zprofile ~/.zlogin ~/.zlogout ~/.tmux.conf; do
  [ -e "$f" ] || [ -L "$f" ] || continue
  [ -L "$f" ] && case "$(readlink "$f")" in "$DIR"/*) continue;; esac   # already ours
  rel=${f#$HOME/}; mkdir -p "$BK/$(dirname "$rel")"; mv "$f" "$BK/$rel"
done
# Keep personal settings (PATH, conda, pyenv...) from old .zshenv/.zprofile, minus old framework lines
if [ ! -e ~/.zshrc.local ]; then
  for f in "$BK/.zshenv" "$BK/.zprofile"; do
    [ -f "$f" ] || continue
    { echo "# carried over from old ${f##*/}"
      grep -viE 'oh-my-zsh|zprezto|zinit|antigen|zplug|zimfw|p10k|powerlevel|starship|fzf|brew shellenv' "$f" || true
    } >> ~/.zshrc.local
  done
fi
rmdir "$BK" 2>/dev/null || say "Old setup saved in $BK (delete it once you're happy)"

# 2. Fresh oh-my-zsh + plugins
say "Installing oh-my-zsh and plugins"
RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended >/dev/null 2>&1
P=~/.oh-my-zsh/custom/plugins
for r in zsh-users/zsh-autosuggestions zsh-users/zsh-syntax-highlighting zsh-users/zsh-history-substring-search Aloxaf/fzf-tab; do
  git clone -q --depth 1 https://github.com/$r $P/${r#*/}
done

# 3. fzf, oh-my-posh + theme (all in your home folder, no sudo)
say "Installing fzf and oh-my-posh"
git clone -q --depth 1 https://github.com/junegunn/fzf ~/.fzf && ~/.fzf/install --bin >/dev/null
mkdir -p ~/.local/bin ~/.zfunc ~/.cache/oh-my-posh/themes
[ -x ~/.local/bin/oh-my-posh ] || curl -fsSL https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin >/dev/null 2>&1
rm -f ~/.cache/oh-my-posh/init.* ~/.cache/oh-my-posh/*omp.cache   # cached prompt code embeds the old oh-my-posh path
cp "$DIR/blue-owl.omp.json" ~/.cache/oh-my-posh/themes/
chmod 644 ~/.cache/oh-my-posh/themes/blue-owl.omp.json   # the prompt executes this file; keep it writable only by you
# The terminal font lives on the machine you type on, so only install it on a Mac
[ "$OS" = Darwin ] && { ~/.local/bin/oh-my-posh font install Meslo >/dev/null 2>&1 || true; say "Set your terminal font to 'MesloLGM Nerd Font' for prompt icons"; }

# 4. Link configs
ln -sf "$DIR/zshrc" ~/.zshrc
ln -sf "$DIR/tmux.conf" ~/.tmux.conf

# 5. Make zsh the login shell; fall back to switching from bash (e.g. LDAP/domain accounts where chsh fails)
ZSH_BIN="$(command -v zsh)"
if [ "$(basename "${SHELL:-}")" != zsh ]; then
  grep -qx "$ZSH_BIN" /etc/shells 2>/dev/null || { [ "$SUDO" != none ] && echo "$ZSH_BIN" | $SUDO tee -a /etc/shells >/dev/null || true; }
  if ! chsh -s "$ZSH_BIN" 2>/dev/null </dev/null; then
    MARK="# chelys: start zsh"
    for rc in ~/.bashrc ~/.bash_profile; do
      [ -f "$rc" ] || [ "$rc" = ~/.bashrc ] || continue
      grep -qE "chelys: start zsh|exec .*zsh" "$rc" 2>/dev/null || printf '\n%s\n[ -t 1 ] && [ -x "%s" ] && [ -z "$ZSH_VERSION" ] && exec "%s" -l\n' "$MARK" "$ZSH_BIN" "$ZSH_BIN" >> "$rc"
    done
  fi
fi

# Do not exec zsh here: that only replaces this script, leaving zsh nested inside your old shell
say "Done - log out and back in (or run: exec zsh -l) to start using zsh"
