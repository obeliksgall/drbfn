FROM alpine:latest

# Instalacja rsync i strefy czasowej
RUN apk add --no-cache rsync tzdata

# katalogi
RUN mkdir -p /usr/local/bin /logs

# kopiujemy crontab
# usuwam z docker-compose.yaml
#      - ./crontab:/etc/crontabs/root:ro
# crontab w obrazie
COPY crontab /etc/crontabs/root

# wymuszamy LF (usuwamy CR)
#RUN dos2unix /etc/crontabs/root
RUN sed -i 's/\r$//' /etc/crontabs/root

# poprawne prawa
RUN chown root:root /etc/crontabs/root && chmod 644 /etc/crontabs/root

# Uruchomienie crona w trybie pierwszoplanowym (-f) z logowaniem w tle (-d 8)
CMD ["crond", "-f", "-d", "8"]
