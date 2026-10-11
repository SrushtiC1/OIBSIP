#!/usr/bin/env bash
# ==============================================================================
# OASIS INFOBYTE CYBER SECURITY INTERNSHIP - TASK 1 HELPER SCRIPT
# Task: Basic Network Scanning with Nmap
# ==============================================================================
# Usage in Kali Linux / Linux Terminal:
#   chmod +x run_scan.sh
#   ./run_scan.sh
#
# IMPORTANT SAFETY & COMPLIANCE RULES:
# 1. This script is strictly for authorized local lab environments (e.g. your own VM).
# 2. It restricts target addresses to private IPv4 ranges (RFC 1918).
# 3. A private IP address alone does NOT guarantee authorization.
# 4. Never scan systems without explicit, documented permission.
# 5. This script only executes standard reconnaissance; it will NEVER run
#    destructive tests, vulnerability exploits, or brute-force attacks.
# ==============================================================================

set -e

# Terminal colors for clear output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}======================================================================${NC}"
echo -e "${CYAN}      OASIS INFOBYTE - TASK 1: NMAP SCAN AUTOMATION HELPER            ${NC}"
echo -e "${CYAN}======================================================================${NC}"

# Step 1: Verify Nmap installation
echo -e "\n${BLUE}[*] Checking for Nmap installation...${NC}"
if ! command -v nmap >/dev/null 2>&1; then
    echo -e "${RED}[ERROR] Nmap is not installed or not in your system PATH.${NC}"
    echo -e "${YELLOW}To install Nmap on Kali/Ubuntu Linux, run:${NC}"
    echo -e "    sudo apt update && sudo apt install nmap -y"
    exit 1
fi
NMAP_VERSION=$(nmap --version | head -n 1)
echo -e "${GREEN}[+] Nmap is installed:${NC} ${NMAP_VERSION}"

# Step 2: Prompt for Target IP manually
echo -e "\n${YELLOW}[!] Enter the Target IP address manually.${NC}"
echo -e "    Ensure this corresponds to your local authorized VM (e.g., Ubuntu/Metasploitable)."
read -rp "Target IPv4 Address: " TARGET_IP

# Step 3: Validate IPv4 address format
IP_REGEX='^([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})$'
if [[ ! $TARGET_IP =~ $IP_REGEX ]]; then
    echo -e "${RED}[ERROR] Invalid IPv4 address format: '$TARGET_IP'${NC}"
    exit 1
fi

OCTET1="${BASH_REMATCH[1]}"
OCTET2="${BASH_REMATCH[2]}"
OCTET3="${BASH_REMATCH[3]}"
OCTET4="${BASH_REMATCH[4]}"

# Check octet boundaries (0-255)
for octet in "$OCTET1" "$OCTET2" "$OCTET3" "$OCTET4"; do
    if (( octet < 0 || octet > 255 )); then
        echo -e "${RED}[ERROR] Octet out of valid IPv4 range (0-255): $octet${NC}"
        exit 1
    fi
done

# Step 4: Restrict to RFC 1918 Private Ranges
# Range 1: 10.0.0.0/8 (10.0.0.0 - 10.255.255.255)
# Range 2: 172.16.0.0/12 (172.16.0.0 - 172.31.255.255)
# Range 3: 192.168.0.0/16 (192.168.0.0 - 192.168.255.255)
IS_PRIVATE=false

if (( OCTET1 == 10 )); then
    IS_PRIVATE=true
elif (( OCTET1 == 172 && OCTET2 >= 16 && OCTET2 <= 31 )); then
    IS_PRIVATE=true
elif (( OCTET1 == 192 && OCTET2 == 168 )); then
    IS_PRIVATE=true
fi

if [ "$IS_PRIVATE" = false ]; then
    echo -e "${RED}[SAFETY BLOCK] The specified IP '$TARGET_IP' is NOT in a recognized private range.${NC}"
    echo -e "${RED}Permitted ranges are strictly:${NC}"
    echo -e "  - 10.0.0.0/8       (10.0.0.0 - 10.255.255.255)"
    echo -e "  - 172.16.0.0/12    (172.16.0.0 - 172.31.255.255)"
    echo -e "  - 192.168.0.0/16   (192.168.0.0 - 192.168.255.255)"
    echo -e "${RED}Scanning public IP addresses, external networks, or domains is forbidden.${NC}"
    exit 1
fi

echo -e "${GREEN}[+] Target '$TARGET_IP' confirmed within RFC 1918 private address space.${NC}"

# Step 5: Critical Warning & Authorization Confirmation
echo -e "\n${YELLOW}======================================================================${NC}"
echo -e "${YELLOW}                 LEGAL & AUTHORIZATION NOTICE                         ${NC}"
echo -e "${YELLOW}======================================================================${NC}"
echo -e "A private IP address alone does NOT prove authorization! Private IP space"
echo -e "is routinely utilized by universities, enterprises, and public Wi-Fi."
echo -e "You must only scan virtual machines you personally host and own."
echo -e "----------------------------------------------------------------------"
read -rp "Do you confirm this target is YOUR authorized local VM? (yes/no): " AUTH_CONFIRM

if [ "$AUTH_CONFIRM" != "yes" ] && [ "$AUTH_CONFIRM" != "YES" ]; then
    echo -e "${RED}[ABORTED] Scan cancelled. Explicit authorization is mandatory.${NC}"
    exit 1
fi

# Step 6: Test reachability
echo -e "\n${BLUE}[*] Testing host reachability using ICMP ping...${NC}"
if ping -c 2 -W 2 "$TARGET_IP" >/dev/null 2>&1; then
    echo -e "${GREEN}[+] Host $TARGET_IP is alive and responding to ping.${NC}"
else
    echo -e "${YELLOW}[!] Warning: Host $TARGET_IP did not respond to ICMP ping.${NC}"
    echo -e "    It may be offline, on a different subnet, or blocking ICMP."
    read -rp "Do you wish to proceed with the port scan anyway? (yes/no): " PROCEED_PING
    if [ "$PROCEED_PING" != "yes" ] && [ "$PROCEED_PING" != "YES" ]; then
        echo -e "${RED}[ABORTED] Scan aborted.${NC}"
        exit 1
    fi
fi

# Step 7: Execute Scan 1 - Basic Port Scan
echo -e "\n${CYAN}----------------------------------------------------------------------${NC}"
echo -e "${CYAN}Step 1: Basic TCP Port Scan${NC}"
echo -e "${CYAN}----------------------------------------------------------------------${NC}"
CMD1="nmap $TARGET_IP -oN basic_scan.txt"
echo -e "Command to execute: ${GREEN}$CMD1${NC}"
echo -e "Output destination : basic_scan.txt"
read -rp "Press [Enter] to run Scan 1 (or 's' to skip): " CHOICE1

if [ "$CHOICE1" != "s" ] && [ "$CHOICE1" != "S" ]; then
    echo -e "${BLUE}[*] Running Basic Scan...${NC}"
    if eval "$CMD1"; then
        echo -e "${GREEN}[+] Scan 1 completed successfully and saved to basic_scan.txt.${NC}"
    else
        echo -e "${RED}[ERROR] Scan 1 failed to execute.${NC}"
    fi
else
    echo -e "${YELLOW}[-] Skipped Scan 1.${NC}"
fi

# Step 8: Execute Scan 2 - Service Version Detection Scan
echo -e "\n${CYAN}----------------------------------------------------------------------${NC}"
echo -e "${CYAN}Step 2: Service & Version Detection Scan${NC}"
echo -e "${CYAN}----------------------------------------------------------------------${NC}"
CMD2="nmap -sV $TARGET_IP -oN service_scan.txt"
echo -e "Command to execute: ${GREEN}$CMD2${NC}"
echo -e "Output destination : service_scan.txt"
read -rp "Press [Enter] to run Scan 2 (or 's' to skip): " CHOICE2

if [ "$CHOICE2" != "s" ] && [ "$CHOICE2" != "S" ]; then
    echo -e "${BLUE}[*] Running Service Version Detection Scan...${NC}"
    if eval "$CMD2"; then
        echo -e "${GREEN}[+] Scan 2 completed successfully and saved to service_scan.txt.${NC}"
    else
        echo -e "${RED}[ERROR] Scan 2 failed to execute.${NC}"
    fi
else
    echo -e "${YELLOW}[-] Skipped Scan 2.${NC}"
fi

# Step 9: Execute Scan 3 - Operating System Detection Scan
echo -e "\n${CYAN}----------------------------------------------------------------------${NC}"
echo -e "${CYAN}Step 3: Operating System Detection Scan (Requires Root Privileges)${NC}"
echo -e "${CYAN}----------------------------------------------------------------------${NC}"
CMD3="sudo nmap -O $TARGET_IP -oN os_scan.txt"
echo -e "Command to execute: ${GREEN}$CMD3${NC}"
echo -e "Output destination : os_scan.txt"
echo -e "${YELLOW}[Note] Root privileges (sudo) are required to craft raw TCP/IP stack fingerprint probes.${NC}"
read -rp "Press [Enter] to run Scan 3 (or 's' to skip): " CHOICE3

if [ "$CHOICE3" != "s" ] && [ "$CHOICE3" != "S" ]; then
    echo -e "${BLUE}[*] Running OS Detection Scan...${NC}"
    if eval "$CMD3"; then
        echo -e "${GREEN}[+] Scan 3 command finished and saved to os_scan.txt.${NC}"
        
        # Transparently check if OS detection succeeded or was inconclusive
        if grep -qi "No exact OS matches for host" os_scan.txt; then
            echo -e "${YELLOW}[!] Notice: Nmap reported no exact OS match for this host.${NC}"
            echo -e "    This is normal when target filtering is strict or stack responses are non-standard."
        elif grep -qi "Too many fingerprints match" os_scan.txt; then
            echo -e "${YELLOW}[!] Notice: Multiple candidate OS fingerprints matched.${NC}"
        elif grep -qi "OS details:" os_scan.txt; then
            echo -e "${GREEN}[+] Remote OS details were successfully identified in os_scan.txt.${NC}"
        fi
    else
        echo -e "${RED}[ERROR] Scan 3 failed. Ensure sudo permissions are available.${NC}"
    fi
else
    echo -e "${YELLOW}[-] Skipped Scan 3.${NC}"
fi

# Step 10: Final Checklist and Next Steps
echo -e "\n${CYAN}======================================================================${NC}"
echo -e "${CYAN}                     SCAN EXECUTION COMPLETE                          ${NC}"
echo -e "${CYAN}======================================================================${NC}"
echo -e "Generated output files in project folder:"
ls -lh basic_scan.txt service_scan.txt os_scan.txt 2>/dev/null || true
echo -e "\n${YELLOW}Next Actions Required:${NC}"
echo -e "  1. Review generated scan files: basic_scan.txt, service_scan.txt, os_scan.txt."
echo -e "  2. Populate 'nmap_scan_results.txt' with your actual findings and analysis table."
echo -e "  3. Take screenshots of your terminal outputs and save them into 'screenshots/' as:"
echo -e "     - screenshots/01_basic_scan.png"
echo -e "     - screenshots/02_service_scan.png"
echo -e "     - screenshots/03_os_scan.png"
echo -e "  4. Follow 'DEMO_VIDEO_GUIDE.md' to record your 2-4 minute demonstration video."
echo -e "  5. Commit and push your changes to your GitHub repository."
echo -e "======================================================================\n"
