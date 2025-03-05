current_path=$PWD
cd $DOTFILES_FOLDER
while IFS="" read -r p || [ -n "$p" ]
do
  echo "removing $p"
  rm -rf ~/"$p"
done < logs/files.txt

echo "\n\n👾 Done! Terminal will quit 2 seconds\n\n"
sleep 2

kill -9 $PPID
