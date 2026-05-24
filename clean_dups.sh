#!/bin/bash

LIB="proprietary/vendor/lib"
LIB64="proprietary/vendor/lib64"

echo "=== Удаление дубликатов .so файлов из lib/ (если есть в lib64/) ==="

count=0
for so in $(find "$LIB" -name "*.so" -type f); do
    name=$(basename "$so")
    if [ -f "$LIB64/$name" ]; then
        echo "Удаляю: $name"
        rm -f "$so"
        ((count++))
    fi
done

echo "Удалено файлов: $count"
echo "Готово."
