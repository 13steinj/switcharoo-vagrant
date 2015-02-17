dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

while IFS= read -d $'\0' -r file ; do 
  echo "INFO-CMD: cd ${file} && npm link"
  ( cd ${file} && npm link ) &
done < <(find ${dir}/../src -mindepth 1 -maxdepth 1 -type d -print0)

wait

echo "npm linked all src files"
