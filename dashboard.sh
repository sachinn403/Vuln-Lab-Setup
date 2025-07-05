#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_SCRIPT="$SCRIPT_DIR/install/install_apps.sh"
RUN_SCRIPT="$SCRIPT_DIR/docker/docker_runner.sh"
COMMON_FILE="$SCRIPT_DIR/common.sh"
INSTALL_DIR="/opt/vuln-lab-setup"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Root check
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[!] Please run this script as root (use sudo)${NC}"
    exit 1
fi

# Load functions
if [ ! -f "$COMMON_FILE" ]; then
    echo -e "${RED}[!] Missing common.sh file. Exiting.${NC}"
    exit 1
fi
source "$COMMON_FILE"

while true; do
    echo -e "\n${BLUE}===== Vulnerable Apps Dashboard =====${NC}"
    echo -e "${GREEN}[1]${NC} Install Apps"
    echo -e "${GREEN}[2]${NC} Run Apps"
    echo -e "${GREEN}[3]${NC} View Running Apps"
    echo -e "${GREEN}[4]${NC} Stop Apps (One/Multiple/All)"
    echo -e "${GREEN}[5]${NC} Exit"
    read -rp "Enter your choice: " choice

    case "$choice" in
        1)
            bash "$INSTALL_SCRIPT" "$INSTALL_DIR"
            ;;
        2)
            bash "$RUN_SCRIPT"
            ;;
        3)
            show_running_apps
            ;;
        4)
            echo -e "\n${BLUE}Running Containers:${NC}"
            docker ps --format '{{.Names}}' || { echo -e "${RED}Docker not running or permission denied.${NC}"; continue; }
            echo -e "\n${GREEN}[1]${NC} Stop One App"
            echo -e "${GREEN}[2]${NC} Stop Multiple Apps"
            echo -e "${GREEN}[3]${NC} Stop All Apps"
            echo -e "${GREEN}[4]${NC} Back to Dashboard"
            read -rp "Choose an option: " stop_choice

            case "$stop_choice" in
                1)
                    read -rp "Enter container name to stop: " cname
                    docker stop "$cname" && echo -e "${YELLOW}Stopped $cname${NC}" || echo -e "${RED}Failed to stop $cname${NC}"
                    ;;
                2)
                    read -rp "Enter container names (space-separated): " -a cnames
                    for cname in "${cnames[@]}"; do
                        docker stop "$cname" && echo -e "${YELLOW}Stopped $cname${NC}" || echo -e "${RED}Failed to stop $cname${NC}"
                    done
                    ;;
                3)
                    docker ps -q | xargs -r docker stop
                    docker container prune -f >/dev/null
                    echo -e "${GREEN}All apps stopped and cleaned up.${NC}"
                    ;;
                4)
                    continue
                    ;;
                *)
                    echo -e "${RED}[!] Invalid option${NC}"
                    ;;
            esac
            ;;
        5)
            echo -e "${YELLOW}Exiting...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}[!] Invalid choice. Please try again.${NC}"
            ;;
    esac
done
