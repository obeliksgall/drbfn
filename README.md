# Docker Rsync Backup dla NAS (drbfn)

Ten projekt to zautomatyzowany, lekki system kopii zapasowych oparty na Dockerze. Wykorzystuje systemowy `cron` oraz narzędzie `rsync` do regularnego synchronizowania plików pomiędzy różnymi wolumenami. 

## 📂 Wymagane pliki

Aby system działał poprawnie, zapisz poniższe 4 pliki w folderze `/volume1/docker/backup/`:
* `docker-compose.yaml` – Konfiguracja kontenera i mapowanie odpowiednich ścieżek źródłowych oraz docelowych (miejsca zapisu).
* `Dockerfile` – Instrukcja budowy obrazu bazującego na systemie Alpine z zainstalowanym `rsync` i strefą czasową.
* `backup.sh` – Główny skrypt wykonujący kopię zapasową z parametrami `--update`.
* `crontab` – Harmonogram zadań wyzwalający backup oraz zarządzający rotacją logów.

## 🚀 Jak to uruchomić?

1. Otwórz terminal (np. przez SSH) swojego NASa i wejdź do folderu z projektem:
   ```bash
   cd /volume1/docker/backup/
   ```

2. Nadaj uprawnienia do wykonywania dla nowego skryptu bashowego:
   ```bash
   chmod +x backup.sh
   ```

3. Zbuduj i uruchom kontener w tle:
   ```bash
   docker compose up -d --build
   ```

## ⚙️ Harmonogram i zasada działania

Zadania wykonywane są całkowicie automatycznie w tle.

**1. Kopia zapasowa (co 15 minut) dla TEST oraz o 06:00 w Niedzielę dla PROD**
Skrypt `backup.sh` uruchamia się co kwadrans i wykonuje następujące operacje:
* Synchronizuje folder `/src/share1/` do miejsca zapisu `/backup2/` (fizycznie z `/volume2/TEST/Dowyslania` do `/volume2/TEST2/kat2:`).
* Synchronizuje folder `/src/share2/` do miejsca zapisu `/backup1/` (fizycznie z `/volume2/TEST/Dowyslania2` do `/volume2/TEST2/kat1:`).

**2. Rotacja logów (codziennie o 06:55)**
* Wyjście ze skryptu zapisywane jest w pliku `/logs/backup.log`.
* Codziennie rano plik logów otrzymuje dopisek z obecną datą.
* System automatycznie zachowuje historię logów z ostatnich 7 dni, a starsze usuwa.
