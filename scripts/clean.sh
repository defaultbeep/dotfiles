while IFS="" read -r p || [ -n "$p" ]
do
  rm -rf ~/"$p"
done < logs/files.txt

echo "\n\n👾 Please restart your terminals\n\n"
