#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PROPRIETARY_DIR="proprietary/vendor"
AOSP_SYSTEM="../../../out/target/product/kl5n/system/vendor"
AOSP_VENDOR="../../../out/target/product/kl5n/vendor"
LOG="dup_log.txt"

echo -e "${YELLOW}=== Поиск конфликтующих .so файлов (proprietary vs AOSP) ===${NC}"
echo "=== Conflicts found on $(date) ===" > "$LOG"

dup=0

for file in $(find "$PROPRIETARY_DIR" -name "*.so" -type f); do
    relative="${file#$PROPRIETARY_DIR/}"
    
    if [ -f "$AOSP_SYSTEM/$relative" ] || [ -f "$AOSP_VENDOR/$relative" ]; then
        ((dup++))
        echo -e "${RED}CONFLICT: $relative${NC}"
        echo "CONFLICT: $relative" >> "$LOG"
    fi
done

echo -e "\n${YELLOW}=== ИТОГ ===${NC}"
echo "Конфликтующих файлов: $dup"
echo "Лог: $LOG"

if [ $dup -gt 0 ]; then
    echo -e "\n${YELLOW}Удалить все конфликтующие файлы из proprietary? (y/n)${NC}"
    read -r answer
    if [ "$answer" = "y" ]; then
        for file in $(find "$PROPRIETARY_DIR" -name "*.so" -type f); do
            relative="${file#$PROPRIETARY_DIR/}"
            if [ -f "$AOSP_SYSTEM/$relative" ] || [ -f "$AOSP_VENDOR/$relative" ]; then
                echo "Удаляю: $file"
                rm -f "$file"
            fi
        done
        echo -e "${GREEN}Готово!${NC}"
    fi
fi
