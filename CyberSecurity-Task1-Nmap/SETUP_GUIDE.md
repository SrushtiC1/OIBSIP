# Beginner Setup & Execution Guide
## Oasis Infobyte Cyber Security Internship — Task 1: Basic Network Scanning with Nmap

This beginner-friendly guide provides step-by-step instructions for executing your scans, documenting your findings, capturing screenshots, and uploading your completed task to GitHub.

---

### Step 1: Open the Project in Antigravity / VS Code

1. Launch **Antigravity** (or Visual Studio Code).
2. Go to **File > Open Folder...**
3. Navigate to and select the `OIBSIP` directory:
   ```text
   C:\Users\Srushti\OneDrive\Desktop\OIBSIP
   ```
4. In the Explorer panel on the left, expand the `CyberSecurity-Task1-Nmap` folder. You will see all project files ready for your scan results.

---

### Step 2: Set Up and Connect Your Lab Virtual Machines

For an authorized, secure scanning lab, you will typically use two virtual machines running in **VirtualBox** or **VMware**:
1. **Scanner VM**: Kali Linux
2. **Target VM**: Ubuntu Server or Metasploitable 2

#### Ensure Both VMs Are on the Same Virtual Network
- In VirtualBox or VMware network settings for both VMs, set the network adapter to **Host-Only Adapter** or **NAT Network**.
- This isolates network traffic completely from the outside internet while allowing the two VMs to communicate.

#### Find the Target VM IP Address
1. In the **Target VM**, open the terminal and run:
   ```bash
   ip a
   # or
   ifconfig
   ```
2. Note the private IPv4 address (e.g., `192.168.56.101`).
3. In your **Kali Linux Scanner VM**, test reachability:
   ```bash
   ping -c 3 192.168.56.101
   ```
   If you receive replies, you are ready to proceed!

---

### Step 3: Transfer or Access the Project Files on Kali Linux

Choose the method that works best for your setup:

#### Method A: Shared Folder (Recommended)
1. In VirtualBox/VMware, set up a **Shared Folder** pointing to `C:\Users\Srushti\OneDrive\Desktop\OIBSIP`.
2. Access the shared folder inside Kali under `/media/sf_OIBSIP/CyberSecurity-Task1-Nmap`.
3. Open your terminal directly in that directory.

#### Method B: Direct Git Clone or Transfer
1. Push this template to your GitHub repository from Windows first (see Step 8).
2. Inside your Kali VM, clone your repo:
   ```bash
   git clone <YOUR_GITHUB_REPO_URL>
   cd OIBSIP/CyberSecurity-Task1-Nmap
   ```

#### Method C: Run Directly in Terminal and Copy Text Files
You can execute the Nmap commands in your Kali terminal and copy the resulting text files (`basic_scan.txt`, `service_scan.txt`, `os_scan.txt`) into this workspace.

---

### Step 4: Execute the Three Progressive Scans

You can run the commands manually or use our interactive helper script:

#### Option 1: Manual Execution (Recommended for Learning)
Replace `TARGET_IP` with your target VM's real IP address (e.g., `192.168.56.101`):

1. **Basic Port Scan**:
   ```bash
   nmap 192.168.56.101 -oN basic_scan.txt
   ```
2. **Service Version Detection Scan**:
   ```bash
   nmap -sV 192.168.56.101 -oN service_scan.txt
   ```
3. **Operating System Detection Scan (Requires Root Privileges)**:
   ```bash
   sudo nmap -O 192.168.56.101 -oN os_scan.txt
   ```

#### Option 2: Using the Helper Script
```bash
chmod +x run_scan.sh
./run_scan.sh
```
The script will prompt you for your target IP, verify that it is in a private RFC 1918 range, ask for authorization confirmation, and guide you through running all three scans sequentially.

---

### Step 5: Capture Authentic Terminal Screenshots

Capture high-resolution screenshots of each completed command in your terminal:

1. **Screenshot 1**:
   - Shows: The basic scan command and its open port list.
   - Save as: `screenshots/01_basic_scan.png`
2. **Screenshot 2**:
   - Shows: The service version scan command and identified software builds.
   - Save as: `screenshots/02_service_scan.png`
3. **Screenshot 3**:
   - Shows: The OS detection scan command (`sudo nmap -O`) and OS fingerprint result.
   - Save as: `screenshots/03_os_scan.png`

> [!NOTE]
> On Windows host, you can press **`Win + Shift + S`** to crop the terminal window. On Kali Linux, press **`PrtScn`** or use `xfce4-screenshooter`.

---

### Step 6: Complete the Assessment Report (`nmap_scan_results.txt`)

Open `nmap_scan_results.txt` in Antigravity or your editor:

1. **Fill in Details**:
   - Replace `[PLACEHOLDER: Insert Your Full Name]` with your real name.
   - Replace scan date, scanner OS, and target IP with your genuine details.
2. **Paste Raw Outputs**:
   - Copy the exact content of `basic_scan.txt` into Section 3.
   - Copy the exact content of `service_scan.txt` into Section 4.
   - Copy the exact content of `os_scan.txt` into Section 5.
3. **Populate Port Analysis Table**:
   - Look at the open ports in `service_scan.txt`.
   - Add each port (e.g., 22/tcp, 80/tcp) to the table in Section 6.
   - Add the detected version, purpose, security considerations, and mitigations based on the guidance in `README.md`.
4. **Fill Summary & Conclusion**:
   - Summarize how many ports were open, which services were found, and what OS was detected.

---

### Step 7: Verification Checklist Before Submission

Verify that all files are in place and complete:

- [ ] `CyberSecurity-Task1-Nmap/README.md` is reviewed.
- [ ] `CyberSecurity-Task1-Nmap/basic_scan.txt` contains real scan output.
- [ ] `CyberSecurity-Task1-Nmap/service_scan.txt` contains real service scan output.
- [ ] `CyberSecurity-Task1-Nmap/os_scan.txt` contains real OS detection output.
- [ ] `CyberSecurity-Task1-Nmap/nmap_scan_results.txt` has all placeholders replaced with real data.
- [ ] `CyberSecurity-Task1-Nmap/screenshots/01_basic_scan.png` exists and displays correctly.
- [ ] `CyberSecurity-Task1-Nmap/screenshots/02_service_scan.png` exists and displays correctly.
- [ ] `CyberSecurity-Task1-Nmap/screenshots/03_os_scan.png` exists and displays correctly.
- [ ] Video demonstration recorded according to `DEMO_VIDEO_GUIDE.md`.

---

### Step 8: Push Your Project to GitHub

Follow these terminal commands in your project root to push your completed work to GitHub:

```bash
# 1. Navigate to the project root
cd C:\Users\Srushti\OneDrive\Desktop\OIBSIP

# 2. Check git status to see all new files
git status

# 3. Add the Task 1 files to git staging
git add CyberSecurity-Task1-Nmap/

# 4. Commit your work with a clear message
git commit -m "Complete Oasis Infobyte Cyber Security Task 1 - Basic Network Scanning with Nmap"

# 5. Push to your GitHub repository
git push origin main
```

*(If you haven't yet connected your GitHub remote, run `git remote add origin <YOUR_GITHUB_REPO_URL>` and `git branch -M main` before pushing.)*

---

### Step 9: Final Task Submission to Oasis Infobyte

1. **GitHub Link**: Copy the direct URL to your `CyberSecurity-Task1-Nmap` folder on GitHub.
2. **Video Link**: Upload your recorded video (2–4 minutes) to LinkedIn or YouTube (Unlisted/Public) and copy the link.
3. **Submission Form**: Submit both links through the official Oasis Infobyte task submission Google Form.
