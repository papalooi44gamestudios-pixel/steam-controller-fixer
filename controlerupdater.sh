#!/bin/bash

# Prüfen, ob das Skript mit Root-Rechten (sudo) ausgeführt wird
if [ "$EUID" -ne 0 ]; then
  echo "[-] Bitte starte das Skript mit Root-Rechten (sudo ./fix_steam_controller.sh)"
  exit 1
fi

# Pfad zum Steam Hardware-Updater ermitteln (standardmäßig im Debian/Ubuntu-Pfad)
UPDATER_DIR=""
POSSIBLE_PATHS=(
  "/home/$SUDO_USER/.steam/debian-installation/bin/hardwareupdater"
  "/home/$SUDO_USER/.local/share/Steam/debian-installation/bin/hardwareupdater"
  "/root/.steam/debian-installation/bin/hardwareupdater"
)

for path in "${POSSIBLE_PATHS[@]}"; do
  if [ -d "$path" ]; then
    UPDATER_DIR="$path"
    break
  fi
done

if [ -z "$UPDATER_DIR" ]; then
  echo "[-] Konnte den hardwareupdater-Ordner nicht finden!"
  echo "    Bitte passe den Pfad im Skript manuell an."
  exit 1
fi

UPDATER_BIN="$UPDATER_DIR/hardwareupdater.x86_64"

if [ ! -f "$UPDATER_BIN" ]; then
  echo "[-] Die Datei hardwareupdater.x86_64 wurde unter $UPDATER_BIN nicht gefunden."
  exit 1
fi

echo "[+] Gefundener Updater: $UPDATER_BIN"
echo "[+] Suche nach verbundenen Steam Controller / Bootloader Geräten..."
echo "------------------------------------------------------------------"

# Geräte anzeigen
"$UPDATER_BIN" --show-all-devices

echo "------------------------------------------------------------------"
echo "Tippe die Seriennummer (Serial Number, z.B. FXA9955201062) ein, die oben angezeigt wird,"
read -p "oder drücke Enter zum Abbrechen: " SERIAL

if [ -z "$SERIAL" ]; then
  echo "Abgebrochen."
  exit 0
fi

echo "[+] Starte das manuelle Update für Seriennummer: $SERIAL ..."
"$UPDATER_BIN" --update-by-serial "$SERIAL"

if [ $? -eq 0 ]; then
  echo "[+] Update erfolgreich abgeschlossen! Das Gerät wurde zurückgesetzt."
else
  echo "[-] Das Update ist mit einem Fehler abgebrochen."
fi
