#!/bin/bash

# Скрипт для обновления локального репозитория Git с помощью команд git pull, git add, git commit и git push.

# Получение последних изменений из удаленного репозитория
git pull origin master

# Добавление всех измененных файлов в индекс
git add .

# Фиксация изменений с описанием "Update" и указанием автора
git commit -m "Update by BoltAI"

# Отправка локальных изменений на удаленный репозиторий в ветку master
git push origin master
