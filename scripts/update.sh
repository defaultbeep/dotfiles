while IFS="" read -r p || [ -n "$p" ]
do
  rm -rf ~/"$p"
done < logs/files.txt

cp -r files/. ~/.

ls -A files > logs/files.txt
echo $(date) > logs/last_update.txt

echo "\n\n👾 Please restart your terminals\n\n"
