# UTF-8 locale: without it zsh miscounts prompt icons and the cursor lands on the space after ❯
if [[ "$(locale charmap 2>/dev/null)" != UTF-8 ]]; then
  for l in en_US.UTF-8 C.UTF-8; do
    locale -a 2>/dev/null | grep -qixE "${l/UTF-8/utf-?8}" && { export LANG=$l LC_CTYPE=$l; unset LC_ALL; break; }
  done
fi
# Homebrew (macOS) - the installer moves ~/.zprofile aside, so set it up here
for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do [ -x $b ] && eval "$($b shellenv)" && break; done
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git docker docker-compose python sudo history fzf-tab zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)
source $ZSH/oh-my-zsh.sh
export PATH="$HOME/.local/bin:$PATH"
command -v oh-my-posh >/dev/null && eval "$(oh-my-posh init zsh --config $HOME/.cache/oh-my-posh/themes/blue-owl.omp.json)"
export PATH="$HOME/.fzf/bin:$PATH"   # git-installed fzf wins over any system copy
command -v fzf >/dev/null && source <(fzf --zsh)
fpath+=~/.zfunc; autoload -Uz compinit; compinit
if [ -f ~/.zshrc.local ]; then source ~/.zshrc.local; fi   # per-server overrides
true   # start with a clean exit status so the first prompt shows no ERROR
