# Oasis Infobyte Cyber Security Internship (OIBSIP)

Repository containing completed tasks and projects for the **Oasis Infobyte Cyber Security Internship Program**.

---

### Tasks Overview

| Level / Task | Project Title | Description | Status | Folder Link |
| :---: | :--- | :--- | :---: | :--- |
| **Level 1 - Task 1** | **Basic Network Scanning with Nmap** | Performing authorized network reconnaissance on a local virtual machine, identifying open ports, service versions, OS fingerprinting, and security assessment. | 🔄 In Progress (Lab Scans Pending) | [📁 View Task 1](CyberSecurity-Task1-Nmap/README.md) |

---

### Project Structure

```text
OIBSIP/
└── CyberSecurity-Task1-Nmap/
    ├── README.md               # Main technical documentation & port analysis
    ├── SETUP_GUIDE.md          # Step-by-step beginner execution guide
    ├── DEMO_VIDEO_GUIDE.md     # Video recording structure, title card & narration
    ├── run_scan.sh             # Interactive scan helper script with safety checks
    ├── nmap_scan_results.txt   # Evaluation report template for findings
    ├── basic_scan.txt          # Raw output from: nmap TARGET_IP -oN basic_scan.txt
    ├── service_scan.txt        # Raw output from: nmap -sV TARGET_IP -oN service_scan.txt
    ├── os_scan.txt             # Raw output from: sudo nmap -O TARGET_IP -oN os_scan.txt
    └── screenshots/            # Directory for real terminal screenshots
        ├── README.md           # Instructions for capturing authentic screenshots
        ├── 01_basic_scan.png   # (Pending user capture)
        ├── 02_service_scan.png # (Pending user capture)
        └── 03_os_scan.png      # (Pending user capture)
```

---

### Disclaimer & Ethical Scope
All scans and assessments in this repository are performed strictly within isolated private virtual lab environments for authorized educational evaluation. No public or third-party networks were scanned without permission.
