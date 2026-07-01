#!/bin/sh

echo "========================================"
echo "Rozpoczynam sesje backupu: $(date)"
echo "========================================"

echo "Backup 1..."
rsync -av --update /src/share1/ /backup2/

echo "Backup 2..."
rsync -av --update /src/share2/ /backup1/

#echo "Backup photo..."
#rsync -av --update /src/photo/ /backup2/photo/

echo "Backup finished: $(date)"
echo "========================================"

