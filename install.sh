#!/bin/bash

# Colors
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${CYAN}[*] Vulnerable Lab Environment Installer${NC}"

# Check root
if [[ "$EUID" -ne 0 ]]; then
    echo -e "${RED}[!] Please run this script as root (use sudo)${NC}"
    exit 1
fi

# Docker install function
install_docker() {
    echo -e "${YELLOW}[*] Installing Docker and dependencies...${NC}"
    
    # Required packages
    apt update
    apt install -y ca-certificates curl gnupg lsb-release apt-transport-https software-properties-common

    # Add Docker’s official GPG key
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    # Add Docker repo
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/debian $(lsb_release -cs) stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Update and install Docker
    apt update
    apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Enable Docker on boot and start service
    systemctl enable docker
    systemctl start docker

    echo -e "${GREEN}[+] Docker installed and running.${NC}"
}

# Docker check
if ! command -v docker &> /dev/null; then
    install_docker
else
    echo -e "${GREEN}[✓] Docker already installed.${NC}"
fi

# Add current user to docker group (optional)
if ! groups "$SUDO_USER" | grep -qw docker; then
    echo -e "${YELLOW}[*] Adding $SUDO_USER to docker group...${NC}"
    usermod -aG docker "$SUDO_USER"
    echo -e "${CYAN}[!] Please log out and log back in or reboot to apply group changes.${NC}"
else
    echo -e "${GREEN}[✓] User $SUDO_USER already in docker group.${NC}"
fi

echo -e "${GREEN}[*] Installation complete. You can now run ./dashboard.sh${NC}"
