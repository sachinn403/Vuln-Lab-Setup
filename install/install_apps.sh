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

# Check required dependencies
for cmd in git docker wget; do
    command -v "$cmd" >/dev/null 2>&1 || {
        echo -e "${RED}[!] Required command '$cmd' not found. Please install it.${NC}"
        exit 1
    }
done

# Validate application list file
if [ ! -s "$APP_LIST" ]; then
    echo -e "${RED}[!] Application list is empty or missing: $APP_LIST${NC}"
    exit 1
fi

# Create install directory if not exists
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR" || {
        echo -e "${RED}[!] Failed to create install directory: $INSTALL_DIR${NC}"
        exit 1
    }
fi

# Display install menu
echo -e "${BLUE}Install vulnerable apps:${NC}"
echo "1. Install All"
echo "2. Select apps"
echo "3. Go Back"
read -rp "Enter your choice [1/2/3]: " install_choice

if [ "$install_choice" == "3" ]; then
    echo -e "${YELLOW}Returning to main menu...${NC}"
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
                target_dir="$INSTALL_DIR/$(basename "$url" .git)"
                if [ -d "$target_dir" ]; then
                    echo -e "${YELLOW}[!] $name already exists at $target_dir. Skipping...${NC}"
                else
                    git clone "$url" "$target_dir"
                fi
                ;;
            release)
                fname="$(basename "$url")"
                if [ -f "$INSTALL_DIR/$fname" ]; then
                    echo -e "${YELLOW}[!] $fname already exists. Skipping...${NC}"
                else
                    wget -q --show-progress -O "$INSTALL_DIR/$fname" "$url"
                fi
                ;;
            docker)
                echo -e "${BLUE}[*] Pulling Docker image: $url${NC}"
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

echo -e "${GREEN}[✔] Installation process completed.${NC}"
