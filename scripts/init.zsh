#!/bin/zsh

current_dir=$(basename "$PWD")

if [[ "$current_dir" != "dotfiles" ]]; then
  echo "‼️  Move to your dotfiles directory and run this again"
  exit 1;
fi

if [ -f logs/files.txt ]; then
  while IFS="" read -r p || [ -n "$p" ]
  do
    rm -rf ~/"$p"
  done < logs/files.txt
fi

cp -r files/. ~/.

rm -f ~/.bash_profile
rm -f ~/.profile

echo "export DOTFILES_FOLDER=\"$(pwd)\"" > ~/.env

if [ ! -f ~/.aliases.private ]; then
  echo "# Your private aliases" > ~/.aliases.private
fi

if [ ! -f ~/.env.private ]; then
  echo "# Your private env vars" > ~/.env.private
fi

if [ ! -f ~/.gitconfig.private ]; then
  echo "# Your private git config" > ~/.gitconfig.private
fi

# brew bundle --file=~/Brewfile

ls -A files > logs/files.txt
date "+%s" > logs/last_update.txt

read "REPLY?👾 Done! Restart terminal to see changes? [Y/n] "

if [[ "$REPLY" == "" || "$REPLY" =~ ^[Yy]([Ee][Ss])?$ ]]; then
  case "$TERM_PROGRAM" in
    iTerm.app)
      osascript -e 'tell application "iTerm2" to create window with default profile'
      ;;
    Apple_Terminal)
      osascript -e 'tell application "Terminal" to do script ""'
      ;;
    *)
      echo "⚠️  Couldn't detect your terminal application. \n    Please restart terminal manually.\n"
      exit
      ;;
  esac

  exit
else
  echo "👍  Continuing with the current terminal \n    (Restart to see changes when you can)\n"
fi