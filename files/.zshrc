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
  echo "%{$fg_bold[red]%}%1d%{$reset_color%}"
}

git_prompt_info() {
  current_branch=$(git cb 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo "%{$fg_bold[green]%}[$current_branch]%{$reset_color%} "
  fi
}

PS1='* $(prompt_path) $(git_prompt_info) ~ '

# Set NVM dir

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Set editor
export VISUAL=vim
export EDITOR=$VISUAL

# Set autocomplete
autoload -U compinit
compinit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
setopt extendedglob
unsetopt nomatch
DIRSTACKSIZE=10

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Set Environment Variables
[[ -f ~/.env ]] && source ~/.env
[[ -f ~/.env.private ]] && source ~/.env.private

# Set aliases
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.aliases.private ]] && source ~/.aliases.private
