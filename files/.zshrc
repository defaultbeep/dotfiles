for function in ~/.zsh/functions/*; do
  source $function
done

[[ -f ~/.env ]] && source ~/.env
[[ -f ~/.aliases ]] && source ~/.aliases

export PATH="~/.composer/vendor/bin:$PATH" # composer
export PATH="/usr/local/bin:/usr/local/sbin:$PATH" # homebrew
export PATH="$HOME/.bin:$PATH" # rbenv

eval "$(rbenv init - --no-rehash zsh)"

# colors
autoload -U colors
colors
export CLICOLOR=1

# prompt
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

PS1='* $(prompt_path) $(git_prompt_info)~ '

# set editor
export VISUAL=vim
export EDITOR=$VISUAL

# history config
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# auto complete
autoload -U compinit
compinit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
setopt extendedglob
unsetopt nomatch
DIRSTACKSIZE=10

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
