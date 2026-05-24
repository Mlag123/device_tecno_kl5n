#!/bin/bash

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Поиск дублирующихся .so файлов ===${NC}\n"

# Пути
PROPRIETARY_DIR="proprietary/vendor"
AOSP_SYSTEM="../../../../out/target/product/kl5n/system"
AOSP_VENDOR="../../../../out/target/product/kl5n/vendor"

# Функция проверки существования файла в AOSP
check_duplicate() {
    local file="$1"
    local relative_path="${file#$PROPRIETARY_DIR/}"
    
    # Проверяем в system/vendor и vendor
    if [[ -f "$AOSP_SYSTEM/vendor/$relative_path" ]] || \
       [[ -f "$AOSP_VENDOR/$relative_path" ]]; then
        echo -e "${RED}❌ DUPLICATE: $relative_path${NC}"
        return 1
    else
        echo -e "${GREEN}✅ OK: $relative_path${NC}"
        return 0
    fi
}

# Находим все .so файлы и проверяем
count=0
duplicates=0

while IFS= read -r file; do
    ((count++))
    if ! check_duplicate "$file"; then
        ((duplicates++))
    fi
done < <(find "$PROPRIETARY_DIR" -name "*.so" -type f)

echo -e "\n${YELLOW}=== Итог ===${NC}"
echo -e "Всего .so файлов: $count"
echo -e "${RED}Дублей: $duplicates${NC}"

if [[ $duplicates -gt 0 ]]; then
    echo -e "\n${YELLOW}Хочешь удалить все дубликаты? (y/n)${NC}"
    read -r answer
    if [[ "$answer" == "y" ]]; then
        while IFS= read -r file; do
            relative_path="${file#$PROPRIETARY_DIR/}"
            if [[ -f "$AOSP_SYSTEM/vendor/$relative_path" ]] || \
               [[ -f "$AOSP_VENDOR/$relative_path" ]]; then
                echo "Удаляю: $file"
                rm -f "$file"
            fi
        done < <(find "$PROPRIETARY_DIR" -name "*.so" -type f)
        echo -e "${GREEN}Дубликаты удалены!${NC}"
    fi
fi
