# OASIS INFOBYTE Cyber Security Internship — Task 2
## Basic Firewall Configuration with UFW (Uncomplicated Firewall)

---

## 1. Project Overview & Objectives

In modern computing environments, every connected operating system is continually exposed to network traffic. Without protective filtering mechanisms, rogue scans, unauthorized remote access attempts, and malicious payloads can reach open ports and vulnerable network services.

The primary objective of **Task 2** is to implement host-based packet filtering on **Kali Linux** using **UFW (Uncomplicated Firewall)**. Through this project, we:
- Establish a **Default-Deny** inbound security posture based on the **Principle of Least Privilege**.
- Permit authorized administrative ingress on specific ports (SSH on port 22, HTTPS on port 443).
- Explicitly block unencrypted or insecure traffic (HTTP on port 80, Telnet on port 23).
- Verify the active firewall state using verbose diagnostic commands.
- Implement a controlled, scientific testing methodology to verify traffic filtration.
- Capture authentic lab evidence and prepare a video demonstration for evaluation.

---

## 2. Fundamental Cybersecurity Concepts (Explained Simply)

### What is a Firewall?
Imagine an apartment building with an entrance door. A **firewall** acts like the building security guard stationed at that door. When someone (a data packet) arrives:
1. The guard checks their credentials (source IP address, destination IP, port number, and protocol).
2. The guard compares this against an approved visitor list (the **firewall ruleset**).
3. If the visitor is on the list, they are allowed in (**ALLOW**). If not, they are turned away or ignored (**DENY / DROP / REJECT**).

In technical terms, a host-based firewall inspects network packets at the Network (Layer 3) and Transport (Layer 4) layers of the OSI model, deciding whether to forward, drop, or accept them based on defined policies.

### What is UFW and Why Use It?
Linux kernels include a powerful packet-filtering framework called **Netfilter** (managed via tools like `iptables` or `nftables`). However, raw `iptables` syntax is notorious for being complex and error-prone.

**UFW** stands for **Uncomplicated Firewall**. It is an intuitive, user-friendly command-line frontend developed by Canonical for managing `iptables`/`nftables` rules in Debian and Ubuntu-based Linux distributions. UFW translates straightforward commands like `ufw allow 22/tcp` into robust kernel-level packet filter rules.

---

## 3. Lab Environment & Prerequisites

This lab uses a hybrid virtualization setup:

| Component | Specification | Role |
| :--- | :--- | :--- |
| **Host Operating System** | Windows 10 / 11 | Host system running the hypervisor, video recording (OBS Studio), and documentation editor. |
| **Virtual Machine (VM)** | Kali Linux (Debian-based) | Target guest operating system where UFW is installed, configured, and tested. |
| **Hypervisor** | VMware Workstation / Player | Manages virtualized hardware and isolated internal networking. |
| **Code Editor** | Antigravity IDE | Local workspace editor used for code review, documentation drafting, and repository management on Windows. |
| **Network Architecture** | VMware Host-Only / Private NAT | Isolated private network subnet ensuring tests never touch public internet infrastructure. |

### Division of Responsibilities (Windows vs. Kali Linux)
- **Windows (Antigravity & OBS Studio)**:
  - Edit and maintain documentation (`README.md`, `testing_notes.md`, `demo_script.md`).
  - Manage Git repository version control.
  - Record the screen with OBS Studio during the final demonstration.
- **Kali Linux (VMware Console)**:
  - Run the bash configuration script (`sudo ./ufw_configuration.sh`).
  - Apply system-level kernel firewall rules.
  - Run the temporary Python HTTP server for testing.
  - Generate authentic terminal logs and capture screenshots.

---

## 4. Rule Rationale: Why These Specific Rules?

Our security policy adheres to the industry-standard **Default-Deny** architecture:

```
[ Incoming Network Traffic ]
            │
            ▼
┌───────────────────────────────────────┐
│       UFW Packet Filter Matrix        │
├───────────────┬───────────────────────┤
│ Port 22/tcp   │ ALLOW (SSH Remote CLI)│
│ Port 443/tcp  │ ALLOW (Encrypted Web) │
│ Port 80/tcp   │ DENY  (Plaintext HTTP)│
│ Port 23/tcp   │ DENY  (Legacy Telnet) │
│ All other ports│ DENY  (Default Ingress)│
└───────────────┴───────────────────────┘
```

1. **Default Incoming: DENY**
   - *Rationale*: Any unsolicited inbound packet from any network is dropped by default unless explicitly allowed. This eliminates accidental exposure of unauthorized listening ports.
2. **Default Outgoing: ALLOW**
   - *Rationale*: Outbound traffic initiated by the local operating system (such as running `sudo apt update`, querying DNS, or downloading tools) is permitted.
3. **Port 22/TCP (SSH): ALLOW**
   - *Rationale*: Secure Shell provides encrypted remote management, secure file transfers (SFTP/SCP), and secure terminal access.
4. **Port 80/TCP (HTTP): DENY**
   - *Rationale*: Standard HTTP transmits data in cleartext without encryption, exposing credentials and session tokens to eavesdropping and man-in-the-middle (MitM) attacks. Blocking port 80 enforces secure protocol adoption.
5. **Port 443/TCP (HTTPS): ALLOW**
   - *Rationale*: HTTPS uses Transport Layer Security (TLS) to encrypt web communications, providing confidentiality and integrity.
6. **Port 23/TCP (Telnet): DENY**
   - *Rationale*: Telnet is an obsolete legacy remote login protocol developed in 1969. It transmits usernames and passwords completely unencrypted over the wire. Explicitly denying port 23 reinforces defensive posture against legacy credential sniffing.

---

## 5. Step-by-Step Installation and Execution Guide

Execute the following commands in order inside your **Kali Linux VM terminal**:

### Step 1: Open the Project Directory in Kali Linux
If you shared the repository folder with your VM (via VMware Shared Folders) or cloned it into your Kali home directory:
```bash
cd CyberSecurity-Task2-UFW
```

### Step 2: Grant Execution Permissions
Make the configuration script executable:
```bash
chmod +x ufw_configuration.sh
```

*(Optional troubleshooting: If the script gives `\r: command not found` due to Windows line endings, run `sed -i 's/\r$//' ufw_configuration.sh` or `dos2unix ufw_configuration.sh`).*

### Step 3: Execute the Configuration Script
Run the script with administrative privileges:
```bash
sudo ./ufw_configuration.sh
```

During execution:
1. The script verifies root permissions.
2. It verifies whether UFW is installed (and installs it via `apt-get` if missing).
3. It displays existing rules and prompts: `Do you want to proceed with applying these firewall rules? [y/N]:`.
4. Type `y` and press `Enter`.
5. The default policies and port rules are applied, and UFW is enabled.

### Step 4: Verify the Active Configuration
View the verbose status directly:
```bash
sudo ufw status verbose
```

### Step 5: Save Authentic Command Output
Save the authentic command output to the evidence file:
```bash
sudo ufw status verbose | tee ufw_rules_output.txt
```

---

## 6. Testing the HTTP Deny Rule (The Causality Principle)

> [!IMPORTANT]
> ### Why an Unsuccessful Connection Alone Does Not Prove Firewall Blocking
> A common beginner mistake is running `curl http://<IP>` against an address where no web server is running and claiming "The firewall blocked it!"  
> That conclusion is scientifically invalid. When no service is listening on port 80, the Linux kernel automatically responds with a TCP `RST` (Reset) packet or rejects the request, resulting in `Connection refused`. The failure has **nothing to do with the firewall**.  
> **To prove that the firewall is actively blocking traffic:**  
> A service must be actively running and bound to port 80, but external incoming packets must be intercepted and dropped before they reach that service.

### Controlled Test Procedure (Two VMs or VM + Host on Isolated Network)

1. **Step A: Start a temporary listener on the Target Kali VM**:
   ```bash
   sudo python3 -m http.server 80
   ```
2. **Step B: Verify the listener is bound and active**:
   Open a second terminal window on Kali and run:
   ```bash
   sudo ss -tlpn | grep :80
   ```
   Confirm you see `LISTEN` on `0.0.0.0:80`.
3. **Step C: Test connectivity from the client machine (Second VM or Host)**:
   ```bash
   curl -m 5 -v http://<KALI_IP>
   ```
4. **Step D: Analyze the result**:
   - The connection times out (`Connection timed out` after 5 seconds) or is dropped.
   - The Python server terminal shows **zero** incoming requests, proving packets were dropped at the kernel firewall layer.
5. **Step E: Clean up**:
   Press `Ctrl + C` in the Python server terminal to stop the listener.

*(Note: If a second VM is unavailable in your environment, review [testing_notes.md](testing_notes.md) for how to record the rule status and properly mark the connectivity test as not performed without falsifying results).*

---

## 7. Ethical and Safety Considerations

- **Console vs. SSH Execution**: Always run firewall configuration commands from the local VMware graphical console or direct TTY. If you configure a firewall over a remote SSH session and make a mistake, you can permanently lock yourself out of the system.
- **Private Subnets Only**: All tests and temporary web listeners must strictly be restricted to private IP spaces (e.g., `192.168.x.x` or `10.x.x.x`). Never expose test listeners to the public internet.
- **No Force-Reset**: The provided script intentionally avoids `ufw --force reset` so that pre-existing host configurations are not erased without user consent.

---

## 8. Known Limitations & Technical Nuances

- **Layer 3/4 vs. Layer 7**: UFW is a transport/network layer packet filter. It inspects IP addresses and TCP/UDP ports. It does not inspect the contents of encrypted application payloads (like a Web Application Firewall / WAF would).
- **Loopback Traffic**: Local connections initiated on `localhost` (`127.0.0.1`) are typically permitted by default loopback policies unless explicitly restricted. Real external ingress testing requires a second network interface or virtual peer.

---

## 9. Official References

- [Official Ubuntu Community UFW Documentation](https://help.ubuntu.com/community/UFW)
- [Ubuntu Server Guide: Packet Filtering and Firewalls](https://ubuntu.com/server/docs/firewalls/)
- [Debian Wiki: Uncomplicated Firewall (UFW)](https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29)
