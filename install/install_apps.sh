#!/bin/bash

INSTALL_DIR="${1:-/opt/vuln-lab-setup}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_LIST="$SCRIPT_DIR/../resources/app_list.txt"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

mkdir -p "$INSTALL_DIR"

echo -e "${BLUE}Install vulnerable apps:${NC}"
echo "1. Install All"
echo "2. Select apps"
echo "3. Go Back"
read -rp "Enter your choice [1/2/3]: " install_choice

if [ "$install_choice" == "3" ]; then
    exit 0
fi

apps=()
ids=()
index=1

while IFS='|' read -r id name type url; do
    apps+=("$id|$name|$type|$url")
    ids+=("$index")
    echo "$index. $name"
    ((index++))
done < "$APP_LIST"

selected_ids=()

if [ "$install_choice" == "1" ]; then
    selected_ids=("${ids[@]}")
elif [ "$install_choice" == "2" ]; then
    read -rp "Enter IDs (e.g., 1 3 5) or 'b' to go back: " -a selected_ids
    [[ "${selected_ids[0]}" == "b" ]] && exit 0
else
    echo -e "${RED}[!] Invalid input.${NC}"
    exit 1
fi

for sel in "${selected_ids[@]}"; do
    if [[ "$sel" =~ ^[0-9]+$ ]] && [ "$sel" -le "${#apps[@]}" ]; then
        IFS='|' read -r id name type url <<< "${apps[$((sel-1))]}"
        echo -e "${GREEN}[+] Installing: $name${NC}"
        case "$type" in
            git)
                git clone "$url" "$INSTALL_DIR/$(basename "$url" .git)"
                ;;
            release)
                fname="$(basename "$url")"
                wget -q --show-progress -O "$INSTALL_DIR/$fname" "$url"
                ;;
            docker)
                docker pull "$url"
                ;;
            *)
                echo -e "${RED}[!] Unknown type for $name${NC}"
                ;;
        esac
    else
        echo -e "${RED}[!] Invalid ID: $sel${NC}"
    fi
done
