---
author: Sergey DEDOV
title: Генерация сайта c HUGO на GitHub Pages
description: Сборная инструкция по созданию статичного сайта с использованием генератора HUGO
tags:
  - WEB
  - HUGO
  - GitHub
date: 2023-12-16
keywords: FM, PM
summary: Это подробная инструкция по созданию и размещению статического сайта с использованием генератора HUGO на GitHub Pages
categories: Инструкции
---
Статья представляет собой инструкцию по созданию статического сайта с использованием генератора HUGO и его размещению на GitHub Pages. В статье описаны шаги установки необходимых программ, создание репозитория на GitHub, клонирование репозитория и установка темы для сайта. Также приведены указания по созданию первого сообщения в блоге и настройке сервера HUGO. Далее описывается процесс публикации и деплоя сайта на GitHub Pages, а также настройка самой GitHub Pages. В конце статьи дано краткое заключение об использовании HUGO для создания личных блогов или документации к проекту, а также указан способ переноса сайта с WordPress в Hugo при помощи соответствующего плагина.

**Использованные материалы:**
> - Инструкция на сайте [HUGO](https://gohugo.io/getting-started/quick-start/)
> - Генерация статических сайтов с [Hugo](https://habr.com/ru/articles/700640/)
> - Создаем свой блог на GitHub и [Hugo](https://habr.com/ru/articles/778900/)
> - Генератор статических сайтов [Hugo](https://yamadharma.github.io/ru/post/2020/12/07/hugo-site-generator/)
> - Легкое создание сайтов с [Hugo](https://code.tutsplus.com/ru/make-creating-websites-fun-again-with-hugo-the-static-website-generator-written-in-go--cms-27319t)

## Установка необходимых программ (MacOS) {#MacOS}

1. Установите [Hugo](https://gohugo.io/installation/)
2. Установите [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

Или используйте `brew`:

```bash
brew install hugo git
```

## Создание репозитория на GitHub Pages

1. Создайте репозиторий на GitHub с именем `<ваш_логин>.github.io`.
2. Для разработки сайта создайте еще один репозиторий (например, `hugo`).

## Клонирование репозитория и установка

```bash
git clone git@github.com:<пользователь>/<репозиторий> # не <пользователь>.github.io, а репозиторий для разработки
cd <репозиторий>
```

## Создание сайта с темой [PaperMod](https://github.com/adityatelange/hugo-PaperMod/wiki/Installation)

Открываем терминал и пишем:
```bash

hugo new site quickstart # создаем стуктуру сайта [quickstart]

cd quickstart # смена каталога на сайт

git init # инициализация Git
git add . # добавить все файлы
git commit -m "Initial commit" # первый коммит

echo "Установка темы"
git submodule add -f--depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod  # установка темы
git submodule update --init --recursive # needed when you reclone your repo (submodules may not get cloned automatically)

mv hugo.toml hugo.toml.bak

git remote add origin git@github.com:[ваш-username]/[ваш-repo].git
git branch -M main
git push -u origin main

```

## Создание первого сообщения в блоге

```bash
mkdir post
mkdir post/cool-post
hugo new post/cool-post/cool-post.md
```

После открываем файл `content/post/cool-post.md` и видим обычный [markdown](https://doka.guide/tools/markdown/):

```markdown
---
title: "cool-post"
date: 2023-12-06T22:43:16+07:00
draft: true
---
```

Изображения для постов необходимо хранить в директории сайта. Для этого в Hugo есть понятие ресурсов страницы и глобальных ресурсов. Ресурсы страницы — файлы и медиа, которые нужны нам только в одном посте и больше нигде не понадобятся. Глобальные ресурсы применяются для всего сайта. Поэтому если изображения нужны в статье, то для каждого поста мы создаём отдельную папку в директории `post` и храним в ней файлы поста и медиа к ней.

```bash
content
└── posts
    └── cool-post
        ├── cool-post.md
        ├── cool-post.ru.md
        └── cool-image.jpg
```

Давайте его чуть-чуть изменим:

```markdown
---
author: "Sergey DEDOV"
title: "Привет, хабр!"
description: ""
date: 2023-12-06T22:43:16+07:00
draft: true
tags: ["хабр", "блог"]
categories: ["приветствие", "блог"]
favorite: true #/false
hidden: false #/true
---

# Привет, хабр!

Как дела, хабр?

# Пока, хабр?
```

Разделителями `---` мы добавляем секцию информации о посте.
- `title` — название, заголовок,
- `date` — дата,
- `draft` — черновик,
- `tags` — теги,
- `categories` — категории.
Дальше идет пост в формате Markdown.

## Синтаксис Markdown для генератора сайтов Hugo
[Синтаксис Markdown для генератора сайтов Hugo](https://yamadharma.github.io/ru/post/2020/11/26/hugo-markdown/)


## Создание фотогалереи

Чтобы построить фотогалерею с Hugo, мы будем использовать превосходный инструмент `hugo-gallery`, доступный на [GitHub](https://github.com/icecreammatt/hugo-gallery).

Это так:

```bash
hugo-gallery <Source Path> <Destination> <Title> [BaseUrl]
```

Инструмент `hugo-gallery` создаст новую директорию постов, содержащую файл разметки для каждого изображения в исходном каталоге, для создания упорядоченного слайд-шоу. Он будет считывать все файлы из директории `Source Path` и сохранять их в статическом каталоге сайта hugo.

Он создаст новый каталог внутри каталога содержимого на основе `Title`, например, `content/welding`

**Например:**

```bash
hugo-gallery static/images/welding-photos welding "Photos of my insane welding skills"
```

Посетите `localhost:1313/welding` для просмотра содержимого.

## Настройка сервера HUGO через файл `hugo.yaml`

```bash
cat > hugo.yaml << EOF # Создание файла hugo.yaml

baseURL: "https://hugo.dedov.ws/"
title: ExampleSite
paginate: 5
theme: PaperMod

enableRobotsTXT: true
buildDrafts: false
buildFuture: false
buildExpired: false

googleAnalytics: UA-123-45 # Внести свой

minify:
  disableXML: true
  minifyOutput: true

params:
  env: production # to enable google analytics, opengraph, twitter-cards and schema.
  title: Sergey DEDOV Personal site
  description: "ExampleSite description"
  keywords: [Blog, Portfolio, PaperMod]
  author: Sergey DEDOV
  # author: ["Me", "You"] # multiple authors
  images: ["<link or path of image for opengraph, twitter-cards>"]
  DateFormat: "2/01/2006"
  defaultTheme: auto # dark, light
  disableThemeToggle: false

  ShowReadingTime: true
  ShowShareButtons: true
  ShowPostNavLinks: true
  ShowBreadCrumbs: true
  ShowCodeCopyButtons: false
  ShowWordCount: true
  ShowRssButtonInSectionTermList: true
  UseHugoToc: true
  disableSpecial1stPost: false
  disableScrollToTop: false
  comments: true
  hidemeta: false
  hideSummary: false
  showtoc: true
  tocopen: false

  assets:
    # disableHLJS: true # to disable highlight.js
    # disableFingerprinting: true
    favicon: "<link / abs url>"
    favicon16x16: "<link / abs url>"
    favicon32x32: "<link / abs url>"
    apple_touch_icon: "<link / abs url>"
    safari_pinned_tab: "<link / abs url>"

  label:
    text: "Сергей ДЕДОВ"
    icon: /apple-touch-icon.png
    iconHeight: 35

  # profile-mode
  profileMode:
    enabled: false # needs to be explicitly set
    title: ExampleSite
    subtitle: "This is subtitle"
    imageUrl: "<img location>"
    imageWidth: 120
    imageHeight: 120
    imageTitle: my image
    buttons:
      - name: Posts
        url: posts
      - name: Tags
        url: tags

  # home-info mode
  homeInfoParams:
    Title: "Приветствую на моей страничке \U0001F44B"
    Content: Добро пожаловать!!!

  socialIcons:
    - name: phone
      url: "tel:+79999000000"
    - name: email
      url: "mailto:sergey@dedov.ws"
    - name: facebook
      url: "https://www.facebook.com/Dedov.Sergey/"
    - name: LinkedIn
      url: "https://www.linkedin.com/in/dedovsergey/"

  analytics:
    google:
      SiteVerificationTag: "XYZabc"
    bing:
      SiteVerificationTag: "XYZabc"
    yandex:
      SiteVerificationTag: "XYZabc"

  cover:
    hidden: false # hide everywhere but not in structured data
    hiddenInList: true # hide on list pages and home
    hiddenInSingle: true # hide on single page

  editPost:
    URL: "https://github.com/kiiiiit/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link

  # for search
  # https://fusejs.io/api/options.html
  fuseOpts:
    isCaseSensitive: false
    shouldSort: true
    location: 0
    distance: 1000
    threshold: 0.4
    minMatchCharLength: 0
    keys: ["title", "permalink", "summary", "content"]
menu:
  main:
    - identifier: categories
      name: Категории
      url: /categories/
      weight: 10
    - identifier: tags
      name: Тэги
      url: /tags/
      weight: 20
    - identifier: example
      name: example.org
      url: https://example.org
      weight: 30
# Read: https://github.com/adityatelange/hugo-PaperMod/wiki/FAQs#using-hugos-syntax-highlighter-chroma
pygmentsUseClasses: true
markup:
  highlight:
    noClasses: false
    # anchorLineNos: true
    codeFences: true
    # guessSyntax: true
    # lineNos: true
    style: monokai

EOF
```

!!! Учтите, что этот конфиг — мой, и под тему, которую я использую. Если вы используете другую тему, вам может надо будет изменить конфиг, и написать по другому!

## Публикация и деплой

Время публикации и деплоя нашего сайта на Github Pages!

```bash
git submodule add git@<имя пользователя>.github.io.git public # добавляем наш сайт в директорию public
```

И создаем скрипт для деплоя:

```bash
cat > 2git.sh << EOF # Создание файла для публикации в Git

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
hugo -D

cd public

echo ""
echo ""
echo "Коммитим изменения в $(pwd)"
git add .
git commit -m "$msg"
git push origin

cd ..
echo ""
echo ""
echo "Коммитим изменения в pwd $(pwd)"
git add .
git commit -m "$msg"
git push origin

EOF
```

## Запускаем локальный сервер.

```bash
hugo server -D
```

В выводе терминала должны увидеть строку:
```
Web Server is available at http://localhost:1313/ (bind address 127.0.0.1)
```
Открываем браузер по адресу `http://localhost:1313/`, переходим по этой ссылке, и все отлично!

После этого меняем разрешение на запуск файла. Все директории и файлы проекта загружаем в репозиторий.

```bash
chmod +x 2git.sh
./2git.sh
```

## Настройка GitHub Pages

Переходим в созданный репозиторий и настраиваем GitHub Pages. Для этого идём во вкладку `Pages` настроек репозитория. В качестве `Source` выбираем `Deploy from a branch`. Далее в `Branch` выбираем `main` и директорию `root`, сохраняем. **Важно**, чтобы репозиторий был публичным. После этого сайт будет доступен пользователям по ссылке, которую указали в `baseURL`.

![GitHub Pages Settings](../gitPg.png)

Все готово! После этого немного ожидаем, пока изменения придут на Github. Получаем готовый сайт.

## Что в итоге

В этой статье мы познакомились с генератором статических сайтов Hugo, который считается самым быстрым из доступных вариантов, и разобрали основные принципы работы с ним. Кроме того, прошли весь процесс от установки до публикации сайта на GitHub Pages.

Hugo не всегда бывает удобным, а его возможностей не всегда хватает, но он отличается обилием уже готовых тем, которые просто можно загрузить и применить к проекту. Также можно создавать собственные темы или дорабатывать уже имеющиеся. Hugo может стать хорошим вариантом для личных блогов или документации к проекту.

## Перенос сайта с [WordPress](https://gohugo.io/tools/migrations/#wordpress)

[Wordpress-to-Hugo-exporter](https://github.com/SchumacherFM/wordpress-to-hugo-exporter)

Плагин для WordPress, который позволяет одним кликом преобразовать все записи, страницы, таксономии, метаданные и настройки в формат Markdown и YAML, которые затем можно использовать в Hugo.

**Примечание:** Если у вас возникли проблемы с использованием этого плагина, попробуйте экспортировать свой сайт для [Jekyll](https://wordpress.org/plugins/jekyll-exporter/) и использовать встроенный конвертер Jekyll в Hugo.



