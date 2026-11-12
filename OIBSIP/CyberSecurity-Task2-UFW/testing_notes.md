# Lab Testing Notes: UFW Firewall Verification

**Project**: Oasis Infobyte Cyber Security Internship (OIBSIP)  
**Task 2**: Basic Firewall Configuration with UFW  
**Lab Environment**: Kali Linux (VMware Virtual Machine) | Windows Host System  
**Network Scope**: Isolated Private Virtual Network (Host-Only / NAT Lab Subnet)

---

## 1. Controlled Testing Methodology

In cybersecurity and network administration, verifying that a firewall rule operates as intended requires rigorous methodology:

> [!IMPORTANT]
> **The Causality Principle in Firewall Testing:**  
> An unsuccessful connection (*e.g.*, `curl: (7) Failed to connect` or a timeout) **alone does NOT prove** that a firewall is blocking the traffic!  
> If no application or daemon is actively bound and listening on that port, the operating system kernel will return a TCP `RST` (Connection Refused) or drop packets regardless of whether UFW is enabled or disabled.  
> **To scientifically prove firewall blocking:**  
> 1. A real service must be actively listening on the target port (`TCP 80`).
> 2. The service's listening state must be verified using `ss -tlpn` or `netstat`.
> 3. Traffic must be directed to that active listener from an external system.
> 4. If traffic is blocked or dropped while the service is listening, the firewall is verified as the active filtering agent.

---

## 2. Test Execution Matrix

| Test Name | Source VM / Host | Destination VM | Service & Port | Command Used | Expected Result | Actual Result | Screenshot Filename | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Test 1: UFW Status & Rule Inspection** | Local Kali VM Console | Localhost (`127.0.0.1`) | UFW Subsystem | `sudo ufw status verbose` | Status `active`, default incoming `deny`, default outgoing `allow`, ports 22/443 `ALLOW`, ports 80/23 `DENY`. | *Pending lab execution* | `03_ufw_status_verbose.png` | ⏳ Pending Execution |
| **Test 2: HTTP Port Binding Verification** | Local Kali VM Console | Target Kali VM (`0.0.0.0:80`) | Python HTTP Server (`TCP 80`) | `sudo python3 -m http.server 80` & `sudo ss -tlpn \| grep :80` | Python process successfully binds to port 80; `ss` shows `LISTEN` state on `0.0.0.0:80`. | *Pending lab execution* | `04_http_service_listening.png` | ⏳ Pending Execution |
| **Test 3: Controlled HTTP Deny Ingress Test** | Second VM (or Windows Host on same VMnet) | Target Kali VM (`<KALI_IP>:80`) | HTTP (`TCP 80`) | `curl -m 5 -v http://<KALI_IP>` *(or `nc -zv -w 5 <KALI_IP> 80`)* | Connection times out or is actively rejected by UFW packet filter; no HTTP response received despite active Python server. | *Pending live test execution* | `05_http_deny_test_result.png` | ⏳ Pending Execution / Not Performed |
| **Test 4: SSH Ingress Rule Verification** | Second VM / Host | Target Kali VM (`<KALI_IP>:22`) | SSH (`TCP 22`) | `nc -zv -w 5 <KALI_IP> 22` *(or `ssh -v user@<KALI_IP>`)* | Connection allowed / reaches port (or SSH banner received if `sshd` is running). | *Pending live test execution* | `06_ssh_allow_test.png` *(Optional)* | ⏳ Optional / Pending |
| **Test 5: HTTPS Rule Verification** | Local / Second VM | Target Kali VM (`<KALI_IP>:443`) | HTTPS (`TCP 443`) | `sudo ufw status numbered` | Rule registered as `ALLOW IN` in UFW rule chain. | *Pending live test execution* | `03_ufw_status_verbose.png` | ⏳ Pending Execution |
| **Test 6: Telnet Ingress Deny Verification** | Local / Second VM | Target Kali VM (`<KALI_IP>:23`) | Telnet (`TCP 23`) | `sudo ufw status numbered` | Rule registered as `DENY IN` in UFW rule chain. | *Pending live test execution* | `03_ufw_status_verbose.png` | ⏳ Pending Execution |

> [!NOTE]
> **Single VM Scenario (Fallback Guidance):**  
> If a second virtual machine is not available in your VMware environment, do **NOT** fabricate test results or pretend that remote network packets were blocked. Instead:  
> 1. Document the rule status from `sudo ufw status verbose` as primary evidence of policy configuration.  
> 2. Mark Test 3 as **"Not Performed (Single VM Lab Environment)"**.  
> 3. State clearly in your report: *"In this single-VM setup, rule verification was established via UFW kernel packet tables, while cross-host packet filtration testing was deferred due to the absence of a secondary peer VM."*

---

## 3. Step-by-Step Controlled HTTP Deny Test Procedure

### Phase A: Prepare the Target Kali VM
1. Find your Kali Linux IP address:
   ```bash
   ip -brief address show
   ```
   *(Locate the IP on `eth0` or your host-only adapter, e.g., `192.168.x.x`)*.

2. Launch a temporary, non-production HTTP server on port 80:
   ```bash
   sudo python3 -m http.server 80
   ```
   *Keep this terminal window open.*

3. Open a second terminal window on Kali and verify the port is actively listening:
   ```bash
   sudo ss -tlpn | grep :80
   ```
   *Expected:* You will see `python3` listening on `0.0.0.0:80`.

### Phase B: Perform the Test from a Client Machine
From another VM or from your Windows host (via PowerShell if connected through a VMware Host-Only / NAT adapter):
```bash
# Using curl with a 5-second timeout
curl -m 5 -v http://<KALI_IP>
```
*or using Netcat:*
```bash
nc -zv -w 5 <KALI_IP> 80
```

### Phase C: Observe and Document Behavior
- **With UFW Deny Rule Active**: The connection will hang and time out after 5 seconds (`Connection timed out`), or will be immediately dropped. The Python server in Phase A will show **no incoming requests**.
- **Evidence Screenshot**: Capture the terminal showing the timeout error while the Python server is clearly visible running in the background.

---

## 4. Ethical Scope & Boundary Constraints
- **Private Subnets Only**: All tests must strictly target private, RFC 1918 internal IP addresses (`10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`).
- **No External / Public Scans**: Never test or port-scan external public IP addresses or websites.
- **Immediate Cleanup**: Once the test is finished, terminate the temporary Python HTTP server with `Ctrl + C`.
