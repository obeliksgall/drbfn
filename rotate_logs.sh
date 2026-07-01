#!/bin/sh

LOG_FILE="/logs/backup.log"
DATE=$(date +%Y-%m-%d)

# 1. Przenieś aktualny log (używamy mv, aby zachować ciągłość pliku)
if [ -f "$LOG_FILE" ]; then
    mv "$LOG_FILE" "$LOG_FILE.$DATE"
fi

# 2. Utwórz nowy, pusty plik logu (aby proces backupu miał gdzie pisać)
touch "$LOG_FILE"
chmod 644 "$LOG_FILE"

# 3. Usuń stare logi (starsze niż 7 dni)
find /logs/ -name "backup.log.*" -mtime +7 -delete
