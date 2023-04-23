# Eset Nod32 Update mirror

ESET Nod32 Updates Mirror основе на образе Nginx:stable-alpine и PHP-скрипте <https://github.com/Kingston-kms/eset_mirror_script>

## Требования

- Docker
- Docker Composer

## docker-compose.yml

```YML
---
version: '3.8'

volumes:
    eset-mirror-bases: {}
    eset-mirror-log: {}
    eset-mirror-nginxAuthData: {}

services:
    eset-mirror:
        container_name: eset-mirror
        build:
            context: .
        image: whereisasan/eset-mirror:latest
        environment:
            #Язык программы. Может быть en, ru, ukr
            - scriptLanguage=${scriptLanguage:-ru}
            #[LOG]
            #Тип логгирования.
            #Может принимать следующие параметры:
            #"0" - Отключение логгирования;
            #"1" - Логгирование в файл;
            #"2" - Логгирование в stdout;
            #"3" - Логгирование в файл и stdout.
            - emLogType=${emLogType:-3}
            #Уровень логгирования.
            #Может принимать следующие параметры:
            #"0" - Системные сообщения и сообщения об успешном обновлении;
            #"1" - Системные сообщения, ошибки и сообщения об успешном обновлении;
            #"2" - Системные сообщения, ошибки, замечания и сообщения об успешном обновлении
            #"3" - Системные сообщения, ошибки, замечания и сообщения о процессе обновления
            #"4" - Системные сообщения, ошибки, замечания, сообщения о процессе обновления и поиска ключей
            #"5" - Все вышеперечисленное плюс сообщения отладки.
            - emLogLevel=${emLogLevel:-5}
            #Создание зеркал обновлений для версий, 0 выкл. 1 вкл.
            - esetVersion3=${esetVersion3:-1}
            - esetVersion5=${esetVersion5:-1}
            - esetVersion9=${esetVersion9:-1}
            - esetVersion10=${esetVersion10:-1}
            - esetVersion12=${esetVersion12:-1}
            - esetVersion13=${esetVersion13:-1}
            - esetVersion14=${esetVersion14:-1}
            - esetVersion15=${esetVersion15:-1}
            - esetVersion16=${esetVersion16:-1}
            - esetVersioEP6=${esetVersioEP6:-1}
            - esetVersionEP7=${esetVersioEP7:-1}
            - esetVersionEP8=${esetVersioEP8:-1}
            - esetVersionEP9=${esetVersioEP9:-1}
            - esetVersionEP10=${esetVersioEP10:-1}
            #Разрядность антивируса, 0 выкл. 1 вкл.
            - esetX86=${esetX86:-1}
            - esetX64=${esetX64:-1}
            #Часовой пояс в формате date_default_timezone_set
            - scriptTimezone=${scriptTimezone:-Asia/Tashkent}
            #Показывать использованный логин и пароль в созданном HTML. 0 выкл. 1 вкл.
            - scriptShowLoginLassword=${scriptShowLoginLassword:-0}
        volumes:
            - eset-mirror-bases:/eset-mirror/www/
            - eset-mirror-log:/eset-mirror/log/
            - eset-mirror-nginxAuthData:/eset-mirror/nginxAuthData/
        ports:
            - 8088:80/tcp
```

## Создать образ контейнера

Клонируйте этот репозиторий и создайте образ

```bash
docker build -t whereisasan/eset-mirror:latest . --platform=linux/amd64
```

## Запустить контейнер

Создайте docker-compose.yml файл и запустите

```bash
docker-compose up -d
```

## Конфигурация системы

Настройте Cron на обновление каждые 120 минут

```text
*/120 * * * * docker exec eset-mirror php update.php
```

## Обновление антивирусных баз

```text
docker-compose exec eset-mirror php update.php
```

## Если у вас есть действительный логин: пароль:версия

- Установите их в eset-mirror-log volume nod_keys.valid в формате логин:пароль:версия

## Создание доступа

```text
docker exec eset-mirror htpasswd -b /eset-mirror/nginxAuthData/.htpasswd username password
```

Откройте в вашем браузере:
><http://youip:8088>

## Отладка

- Установите emLogLevel = 5 в файле docker-compose.yml и перезапустите контейнер
- Запустите docker-compose exec eset-mirror php debuging_run.php чтобы просмотреть все сообщения

## PHP и другие модули

- nginx
- php
- curl
- fileinfo
- php-iconv
- mbstring
- openssl
- pcre
- simplexml
- sockets
- zlib

## Документация

Данные приведены только для справки, в ENV достаточно переменных

- Конфигурационный файл /configs/nod32ms.conf
- Конфигурационный файл Nginx /configs/default.conf
