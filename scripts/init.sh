current_dir=$(basename "$PWD")

if [[ "$current_dir" != "dotfiles" ]]; then

  echo "\n\n👾 Move to your dotfiles directory and run this again\n\n"
  kill -9 $PPID
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

echo "export DOTFILES_FOLDER="$(pwd) > ~/.env

if [ ! -f ~/.aliases.private ]; then
  echo "# Your private aliases" > ~/.aliases.private
fi

if [ ! -f ~/.env.private ]; then
  echo "# Your private env vars" > ~/.env.private
fi

ls -A files > logs/files.txt
echo $(date) > logs/last_update.txt


echo "\n\n👾 Done! Terminal will quit 2 seconds\n\n"
sleep 2

kill -9 $PPID