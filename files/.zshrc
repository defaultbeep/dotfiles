# Enable colours
autoload -U colors
colors
export CLICOLOR=1

# Import handy functions
for filename in ~/.zsh/functions/*; do
  source $filename
done

# Customise prompt
setopt promptsubst

prompt_path() {
  echo "%{$fg_bold[red]%}%1~%{$reset_color%}"
}

git_prompt_info() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

    if [[ -n $current_branch ]]; then
      if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        echo "%{$fg_bold[green]%}[$current_branch]%{$reset_color%}*"
      else
        echo "%{$fg_bold[green]%}[$current_branch]%{$reset_color%}"
      fi
    fi
  fi
}

PS1='$(prompt_path)$(git_prompt_info) '

# Set NVM dir

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path=$(nvm_find_nvmrc)

  if [[ -n "$nvmrc_path" ]]; then
    local nvmrc_version
    nvmrc_version=$(cat "$nvmrc_path")

    if [[ "$(nvm version "$nvmrc_version")" == "N/A" ]]; then
      echo "⚠️  Node $nvmrc_version is not installed."
      echo "   Run: nvm install && nvm use"
    else
      nvm use --silent
    fi
  else
    nvm use --silent default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Set editor
export VISUAL=vim
export EDITOR=$VISUAL

# VS Code CLI
if [[ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]]; then
  path+=("/Applications/Visual Studio Code.app/Contents/Resources/app/bin")
fi

# Set autocomplete
autoload -U compinit
compinit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
setopt extendedglob
unsetopt nomatch
DIRSTACKSIZE=10

# Set Environment Variables
[[ -f ~/.env ]] && source ~/.env
[[ -f ~/.env.private ]] && source ~/.env.private

# Set aliases
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.aliases.private ]] && source ~/.aliases.private
