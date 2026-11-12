#!/usr/bin/env bash
# ==============================================================================
# Script Name   : ufw_configuration.sh
# Project       : Oasis Infobyte Cyber Security Internship (OIBSIP) - Task 2
# Title         : Basic Firewall Configuration with UFW (Uncomplicated Firewall)
# Target OS     : Kali Linux (Debian-based) in VMware Workstation / Player
# Author        : Cybersecurity Intern
# ==============================================================================
# Operational Notice:
# This script must be executed locally from the virtual machine console (VMware
# terminal window), NOT over an active remote SSH session, to avoid unexpected
# connection drops while configuring packet filtering policies.
# ==============================================================================

set -euo pipefail

# Visual color codes for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================================================${NC}"
echo -e "${BOLD}${CYAN}  OASIS INFOBYTE CYBER SECURITY INTERNSHIP - TASK 2${NC}"
echo -e "${BOLD}  Automated UFW Firewall Configuration & Policy Hardening${NC}"
echo -e "${BLUE}======================================================================${NC}\n"

# ------------------------------------------------------------------------------
# 1. ROOT PRIVILEGE VERIFICATION
# ------------------------------------------------------------------------------
echo -e "${CYAN}[*] Step 1: Checking user privileges...${NC}"
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}[ERROR] This script requires administrative privileges.${NC}"
    echo -e "Please execute this script using sudo:"
    echo -e "  ${YELLOW}sudo ./ufw_configuration.sh${NC}\n"
    exit 1
fi
echo -e "${GREEN}[✔] Verified: Running with root privileges.${NC}\n"

# ------------------------------------------------------------------------------
# 2. UFW INSTALLATION CHECK (Debian / Kali Linux)
# ------------------------------------------------------------------------------
echo -e "${CYAN}[*] Step 2: Checking if UFW (Uncomplicated Firewall) is installed...${NC}"
if ! command -v ufw >/dev/null 2>&1; then
    echo -e "${YELLOW}[!] UFW is not installed on this system.${NC}"
    echo -e "${CYAN}[*] Updating package repositories and installing ufw...${NC}"
    apt-get update -y
    apt-get install -y ufw
    if ! command -v ufw >/dev/null 2>&1; then
        echo -e "${RED}[ERROR] Failed to install UFW. Please check network/package mirrors.${NC}"
        exit 1
    fi
    echo -e "${GREEN}[✔] UFW successfully installed: $(ufw --version | head -n 1)${NC}\n"
else
    echo -e "${GREEN}[✔] UFW is already installed: $(ufw --version | head -n 1)${NC}\n"
fi

# ------------------------------------------------------------------------------
# 3. SAFETY NOTICE & PRE-EXISTING RULE REVIEW
# ------------------------------------------------------------------------------
echo -e "${YELLOW}============================= SAFETY NOTICE ===========================${NC}"
echo -e "This script does NOT perform a force-reset (ufw --force reset)."
echo -e "It will NOT silently wipe your existing firewall configuration."
echo -e "Existing UFW Status and Rules on this VM:"
echo -e "${YELLOW}----------------------------------------------------------------------${NC}"
ufw status verbose || true
echo -e "${YELLOW}----------------------------------------------------------------------${NC}"
echo -e "Planned changes by this script:"
echo -e "  1. Set Default Incoming Policy  : ${RED}DENY${NC} (Block unsolicited ingress)"
echo -e "  2. Set Default Outgoing Policy  : ${GREEN}ALLOW${NC} (Permit outbound requests/updates)"
echo -e "  3. Rule 1 - Inbound Port 22/tcp : ${GREEN}ALLOW${NC} (Secure Shell / SSH)"
echo -e "  4. Rule 2 - Inbound Port 80/tcp : ${RED}DENY${NC}  (Insecure Plaintext HTTP)"
echo -e "  5. Rule 3 - Inbound Port 443/tcp: ${GREEN}ALLOW${NC} (Secure HTTPS)"
echo -e "  6. Rule 4 - Inbound Port 23/tcp : ${RED}DENY${NC}  (Insecure Legacy Telnet)"
echo -e "  7. Enable UFW service"
echo -e "${YELLOW}======================================================================${NC}\n"

read -r -p "Do you want to proceed with applying these firewall rules? [y/N]: " USER_CONFIRM
case "$USER_CONFIRM" in
    [yY][eE][sS]|[yY])
        echo -e "${GREEN}[✔] User confirmation received. Applying rules...${NC}\n"
        ;;
    *)
        echo -e "${YELLOW}[!] Aborting execution. No firewall changes were made.${NC}"
        exit 0
        ;;
esac

# ------------------------------------------------------------------------------
# 4. CONFIGURE DEFAULT POLICIES (Least Privilege Baseline)
# ------------------------------------------------------------------------------
echo -e "${CYAN}[*] Step 3: Configuring default traffic policies...${NC}"

# Default incoming traffic: DENY
echo -e "  -> Setting default incoming policy to DENY..."
ufw default deny incoming

# Default outgoing traffic: ALLOW
echo -e "  -> Setting default outgoing policy to ALLOW..."
ufw default allow outgoing
echo -e "${GREEN}[✔] Baseline policies applied successfully.${NC}\n"

# ------------------------------------------------------------------------------
# 5. CONFIGURE SPECIFIC PORT RULES
# ------------------------------------------------------------------------------
echo -e "${CYAN}[*] Step 4: Applying port-specific rules...${NC}"

# Rule 1: Allow incoming SSH (TCP Port 22)
echo -e "  -> Allowing incoming TCP port 22 (SSH)..."
ufw allow 22/tcp comment 'Allow incoming SSH'

# Rule 2: Deny incoming HTTP (TCP Port 80)
echo -e "  -> Denying incoming TCP port 80 (HTTP)..."
ufw deny 80/tcp comment 'Deny incoming HTTP'

# Additional Rule 1: Allow incoming HTTPS (TCP Port 443)
echo -e "  -> Allowing incoming TCP port 443 (HTTPS)..."
ufw allow 443/tcp comment 'Allow incoming HTTPS'

# Additional Rule 2: Deny incoming Telnet (TCP Port 23)
echo -e "  -> Denying incoming TCP port 23 (Telnet)..."
ufw deny 23/tcp comment 'Deny incoming Telnet'

echo -e "${GREEN}[✔] All custom firewall rules successfully added.${NC}\n"

# ------------------------------------------------------------------------------
# 6. ENABLE UFW (Only enabled AFTER rules are staged)
# ------------------------------------------------------------------------------
echo -e "${CYAN}[*] Step 5: Activating UFW firewall service...${NC}"
# Use non-interactive enable flag since user confirmation was already collected above
ufw --force enable
echo -e "${GREEN}[✔] UFW is active and enabled on system startup.${NC}\n"

# ------------------------------------------------------------------------------
# 7. VERIFICATION & VERBOSE STATUS DISPLAY
# ------------------------------------------------------------------------------
echo -e "${CYAN}[*] Step 6: Verifying active firewall status and rules...${NC}"
echo -e "${BLUE}==================== ACTIVE UFW CONFIGURATION ====================${NC}"
ufw status verbose
echo -e "${BLUE}==================================================================${NC}\n"

echo -e "${GREEN}${BOLD}[✔] Lab Task 2 Firewall Configuration Completed Successfully!${NC}"
echo -e "\n${BOLD}Next steps for lab verification and evidence capture:${NC}"
echo -e "1. Save actual terminal output to evidence file:"
echo -e "   ${YELLOW}sudo ufw status verbose | tee ufw_rules_output.txt${NC}"
echo -e "2. Refer to ${CYAN}testing_notes.md${NC} to run a controlled HTTP test on an isolated network."
echo -e "3. Note: A port is not verified as blocked until actively tested against a listening service!"
echo -e "4. Refer to ${CYAN}screenshots/README.md${NC} to capture authentic screenshots for submission."
