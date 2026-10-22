# Steam Controller Fixer

An automation script for Linux to manually recover and reflash bricked or bootloader-stuck Steam Controllers (`Triton BL`, USB ID `28de:1005`) and Wireless Receivers ("Pucks") via the command line.

## Background
When the automatic firmware update process in the Steam client fails and the controller remains stuck in bootloader mode (`current_ts: 0x0`), the GUI often becomes unresponsive. This script leverages Steam's official `hardwareupdater` tool to target the device directly by its serial number and restore it.

## Usage

1. Download or clone the script.
2. run:
   ```bash
   chmod +x controlerupdater.sh
4. Run the script with root privileges:
   ```bash
   sudo ./controlerupdater.sh

Disclaimer:
This software is provided "as is", without warranty of any kind, express or implied. Use this script at your own risk. The author assumes no 
responsibility or liability for any damage, bricked hardware, or data loss caused by using this tool.
