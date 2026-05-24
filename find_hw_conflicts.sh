#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PROPRIETARY_DIR="proprietary/vendor"
LOG="conflict_hw.txt"

echo -e "${YELLOW}=== Поиск дубликатов в hw ===${NC}"
echo "=== HW duplicates found on $(date) ===" > "$LOG"

# Временный массив для хранения имён
declare -A seen

# Ищем все файлы в lib/hw и lib64/hw (и любых других hw)
find "$PROPRIETARY_DIR" -type f -path "*/hw/*" | while read -r path; do
    name=$(basename "$path")
    
    if [[ -n "${seen[$name]}" ]]; then
        echo -e "${RED}DUPLICATE: $name${NC}"
        echo "DUPLICATE: $name" >> "$LOG"
        echo "  First: ${seen[$name]}" >> "$LOG"
        echo "  Second: $path" >> "$LOG"
        echo "" >> "$LOG"
    else
        seen["$name"]="$path"
    fi
done

echo -e "\n${GREEN}Лог сохранён в $LOG${NC}"
