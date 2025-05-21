#!/bin/bash

# Проверка количества аргументов
if [ "$#" -ne 2 ]; then
    echo "Использование: $0 <строка_для_поиска> <выходной_файл>"
    exit 1
fi

search_string="$1"
output_file="$2"

# Проверка существования выходного файла
if [ -f "$output_file" ]; then
    printf "Файл '%s' уже существует. Перезаписать? (y/n) " "$output_file"
    read REPLY
    if [ "$REPLY" != "y" ] && [ "$REPLY" != "Y" ]; then
        echo "Отмена выполнения."
        exit 1
    fi
    # Очищаем файл, если пользователь согласился на перезапись
    > "$output_file"
fi

# Поиск файлов .txt, содержащих заданную строку
echo "Поиск строки '$search_string' в файлах .txt..."
grep -rl --include="*.txt" "$search_string" . > "$output_file"

# Проверка результатов
if [ -s "$output_file" ]; then
    count=$(wc -l < "$output_file")
    echo "Найдено $count файлов. Список сохранен в '$output_file'"
else
    echo "Файлы, содержащие '$search_string', не найдены."
    rm -f "$output_file"
fi