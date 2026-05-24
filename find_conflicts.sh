#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

DIR="proprietary/vendor"
LOG="conflicts.txt"

echo -e "${YELLOW}=== Поиск дубликатов внутри $DIR ===${NC}"
echo "=== Duplicates found on $(date) ===" > "$LOG"

# Собираем все .so файлы с их именами и путями
declare -A seen

find "$DIR" -name "*.so" -type f | while read -r path; do
    name=$(basename "$path")
    
    if [[ -n "${seen[$name]}" ]]; then
        echo -e "${RED}DUPLICATE: $name${NC}"
        echo "DUPLICATE: $name" >> "$LOG"
        echo "  ${seen[$name]}" >> "$LOG"
        echo "  $path" >> "$LOG"
        echo "" >> "$LOG"
    else
        seen["$name"]="$path"
    fi
done

echo -e "\n${GREEN}Готово. Лог: $LOG${NC}"
