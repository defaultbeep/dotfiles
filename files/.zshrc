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

# Set Environment Variables
[[ -f ~/.env ]] && source ~/.env
[[ -f ~/.env.private ]] && source ~/.env.private

# Set aliases
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.aliases.private ]] && source ~/.aliases.private
