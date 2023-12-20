#!/bin/sh

set -e

printf "\033[0;32mДеплой на Github!..\033[0m\n"

msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

echo ""
echo ""
echo "Коммитим изменения в $(pwd)"
git add .
git commit -m "$msg"
git push origin