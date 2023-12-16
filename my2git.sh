#!/bin/bash
# https://github.com/cyberspacedk/Git-commands
# Скрипт для обновления локального репозитория Git с помощью команд git pull, git add, git commit и git push.

# Получение последних изменений из удаленного репозитория
git pull

# Добавление всех файлов в индекс
git add .

# Фиксация изменений с сообщением "Update"
git commit -m "Update"

# Отправка локальных изменений на удаленный репозиторий
git push