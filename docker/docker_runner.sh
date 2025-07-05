#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
APP_LIST="$PROJECT_ROOT/resources/app_list.txt"
COMMON_FILE="$PROJECT_ROOT/common.sh"

[ ! -f "$COMMON_FILE" ] && { echo -e "\033[0;31m[!] Missing common.sh file. Exiting.\033[0m"; exit 1; }
source "$COMMON_FILE"

# Colors
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

installed_apps=()
declare -A id_to_app

while IFS='|' read -r id name type url; do
    is_installed "$type" "$url" && installed_apps+=("$id. $name") && id_to_app["$id"]="$name|$type|$url"
done < "$APP_LIST"

[[ ${#installed_apps[@]} -eq 0 ]] && echo -e "${YELLOW}[i] No apps are installed yet.${NC}" && exit 0

echo -e "${BLUE}Choose apps to run (installed only):${NC}"
for app in "${installed_apps[@]}"; do echo "$app"; done
echo "b. Go Back"
read -rp "Enter IDs to run (e.g., 2 4) or 'b' to go back: " -a selected_ids

for selected_id in "${selected_ids[@]}"; do
    [[ "$selected_id" == "b" ]] && exit 0
    IFS='|' read -r name type url <<< "${id_to_app[$selected_id]}"
    container_name="$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -dc 'a-z0-9-')"
    port=$(find_free_port)

    if docker ps --format '{{.Names}}' | grep -q "^$container_name$"; then
        echo -e "${YELLOW}[i] $name is already running. Skipping.${NC}"
        continue
    fi

    echo -e "[+] Starting ${GREEN}$name${NC} on port $port..."
    docker run -d --rm --name "$container_name" -p "$port:80" "$url" >/dev/null 2>&1 && \
        echo -e "[*] $name is running at ${GREEN}http://localhost:$port${NC}" || \
        echo -e "${RED}[!] Failed to run $name${NC}"
done

echo
show_running_apps

