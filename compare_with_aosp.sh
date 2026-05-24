#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PROPRIETARY_DIR="proprietary/vendor"
AOSP_BASE="../../../out/target/product/kl5n"
LOG="aosp_conflicts.txt"

echo -e "${YELLOW}=== Сравнение proprietary/vendor с AOSP ===${NC}"
echo "=== Conflicts found on $(date) ===" > "$LOG"

# Проверяем, существует ли папка out/
if [ ! -d "$AOSP_BASE/system" ] && [ ! -d "$AOSP_BASE/vendor" ]; then
    echo -e "${RED}Ошибка: папка $AOSP_BASE не найдена${NC}"
    echo "Сначала запусти lunch и make, чтобы сгенерировались файлы в out/"
    exit 1
fi

conflicts=0

# Проходим по каждому .so файлу в proprietary
find "$PROPRIETARY_DIR" -name "*.so" -type f | while read -r prop_file; do
    # Берём относительный путь внутри proprietary/vendor
    relative="${prop_file#$PROPRIETARY_DIR/}"
    
    # Проверяем, есть ли такой же файл в AOSP
    if [ -f "$AOSP_BASE/system/vendor/$relative" ] || \
       [ -f "$AOSP_BASE/vendor/$relative" ] || \
       [ -f "$AOSP_BASE/system/$relative" ]; then
        echo -e "${RED}CONFLICT: $relative${NC}"
        echo "CONFLICT: $relative" >> "$LOG"
        ((conflicts++))
    fi
done

echo -e "\n${YELLOW}=== ИТОГ ===${NC}"
echo "Конфликтующих файлов: $conflicts"
echo "Лог: $LOG"
