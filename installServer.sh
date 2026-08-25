#!/bin/bash
set -euo pipefail

# Default to not installing GUI
INSTALL_GUI=false

# Check for arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --gui) INSTALL_GUI=true ;;
        *) echo "Unknown argument: $1" >&2; exit 2 ;;
    esac
    shift
done

run_remote_installer() {
    local url="$1"
    local tmp
    tmp="$(mktemp)"
    trap 'rm -f "$tmp"' RETURN

    echo "Downloading installer from: $url"
    curl --fail --show-error --silent --location \
        --proto '=https' --tlsv1.2 \
        "$url" --output "$tmp"

    if [[ ! -s "$tmp" ]]; then
        echo "Downloaded installer is empty: $url" >&2
        return 1
    fi

    bash "$tmp"
}

echo -e "\e[1;36m[*] Installing acodeX-server... \e[0m"
run_remote_installer "https://raw.githubusercontent.com/bajrangCoder/acodex_server/main/install.sh"
echo -e '\e[1;32m`acodeX-server` installed successfully. Run `axs` to start the server. \e[0m'

# Only install GUI if the --gui flag was provided
if $INSTALL_GUI; then
    echo -e "\e[1;36m[*] Installing GUI-related packages for acodeX-server...\e[0m"
    pkg install x11-repo -y
    pkg install tigervnc -y
    run_remote_installer "https://raw.githubusercontent.com/bajrangCoder/websockify_rs/main/install.sh"
    echo -e "\e[1;32mGUI packages for acodeX-server installed successfully. Run vncserver command and setup password to get started\e[0m"
else
    echo -e "\e[1;33mSkipping GUI installation for acodeX-server. Use --gui flag to install later.\e[0m"
fi
