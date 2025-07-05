#!/bin/bash

# Colors for consistent display
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'



# Check if a tool is installed (git, release, docker)
is_installed() {
    local type="$1"
    local url="$2"

    if [[ "$type" == "git" ]]; then
        local dir_name
        dir_name="$(basename "$url" .git)"
        [[ -d "/opt/vuln-lab-setup/$dir_name" ]]

    elif [[ "$type" == "release" ]]; then
        local file_name
        file_name="$(basename "$url")"
        [[ -f "/opt/vuln-lab-setup/$file_name" || -d "/opt/vuln-lab-setup/${file_name%.*}" ]]

    elif [[ "$type" == "docker" ]]; then
        docker image inspect "$url" >/dev/null 2>&1
    else
        return 1
    fi
}



# Show currently running Docker containers and ports
show_running_apps() {
    echo -e "${BLUE}Currently Running Apps:${NC}"
    local running_containers
    running_containers=$(docker ps --format '{{.Names}} {{.Ports}}')
    if [[ -z "$running_containers" ]]; then
        echo -e "${YELLOW}[i] No running containers.${NC}"
        return
    fi
    while IFS= read -r line; do
        container_name=$(echo "$line" | awk '{print $1}')
        port_info=$(echo "$line" | cut -d' ' -f2-)
        host_port=$(echo "$port_info" | grep -oP '0\.0\.0\.0:\K[0-9]+(?=->)' | head -n 1)
        readable_name=$(echo "$container_name" | sed -E 's/[-_]/ /g' | sed -E 's/\b(.)/\u\1/g')
        if [[ -n "$host_port" ]]; then
            echo -e "[+] ${GREEN}$readable_name${NC} is running at ${GREEN}http://localhost:$host_port${NC}"
        else
            echo -e "${YELLOW}[!] $readable_name is running, but no public HTTP port found${NC}"
        fi
    done <<< "$running_containers"
}



# Find free port between 8000–9000
find_free_port() {
    for port in $(seq 8000 9000); do
        if ! ss -tuln | grep -q ":$port "; then
            echo "$port"
            return
        fi
    done
    echo "[!] No free ports found between 8000-9000" >&2
    exit 1
}
