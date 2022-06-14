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

echo "\n\n👾 Please restart your terminals\n\n"
