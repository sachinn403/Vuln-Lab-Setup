#!/bin/bash

DEST_DIR="${1:-/opt/vuln-lab-setup}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
APP_LIST="$PROJECT_ROOT/resources/app_list.txt"
COMMON_FILE="$PROJECT_ROOT/common.sh"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

[ ! -f "$COMMON_FILE" ] && { echo -e "${RED}[!] Missing common.sh file. Exiting.${NC}"; exit 1; }
source "$COMMON_FILE"

install_app() {
    local id="$1" name="$2" type="$3" url="$4"
    local target_dir="$DEST_DIR/$(basename "$url" .git)"

    if is_installed "$type" "$url"; then
        echo -e "${YELLOW}[i] $name is already installed.${NC}"
        return
    fi

    echo -e "[*] Installing ${YELLOW}$name${NC} to ${BLUE}$DEST_DIR${NC}..."
    [[ "$type" == "docker" ]] && docker pull "$url"
    [[ "$type" == "git" ]] && git clone "$url" "$target_dir"
}

show_available_apps() {
    while IFS='|' read -r id name type url; do
        ! is_installed "$type" "$url" && echo "$id. $name"
    done < "$APP_LIST"
}

echo -e "${BLUE}Install vulnerable apps:${NC}"
echo "1. Install All"
echo "2. Select apps"
echo "3. Go Back"
read -rp "Enter your choice [1/2/3]: " install_choice

[[ "$install_choice" == "3" ]] && exit 0

if [[ "$install_choice" == "1" ]]; then
    while IFS='|' read -r id name type url; do
        install_app "$id" "$name" "$type" "$url"
    done < "$APP_LIST"
else
    echo -e "${BLUE}Available apps (not yet installed):${NC}"
    show_available_apps
    echo "b. Go Back"
    read -rp "Enter IDs (e.g., 1 3 5) or 'b' to go back: " -a selected_ids

    for selected_id in "${selected_ids[@]}"; do
        [[ "$selected_id" == "b" ]] && exit 0
        line=$(grep "^$selected_id|" "$APP_LIST")
        if [ -n "$line" ]; then
            IFS='|' read -r id name type url <<< "$line"
            install_app "$id" "$name" "$type" "$url"
        else
            echo -e "${RED}[!] Invalid ID: $selected_id${NC}"
        fi
    done
fi
