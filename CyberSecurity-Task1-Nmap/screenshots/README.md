# Terminal Screenshots Directory

This directory is designated for your **real, authentic terminal screenshots** taken during scan execution in your authorized local lab.

> [!IMPORTANT]
> **Authenticity Policy**: In strict accordance with academic and internship ethics, **do not upload mock, synthetic, or AI-generated screenshots**. Save the genuine graphical captures from your Kali Linux terminal or host operating system here.

---

### Required Screenshot Files

Save your screenshots in this folder using the exact filenames listed below so that they display automatically in the main [`README.md`](../README.md):

| Filename | Description of Required Capture |
| :--- | :--- |
| **`01_basic_scan.png`** | Terminal window showing the command execution and results of:<br>`nmap TARGET_IP -oN basic_scan.txt` |
| **`02_service_scan.png`** | Terminal window showing the command execution and results of:<br>`nmap -sV TARGET_IP -oN service_scan.txt` |
| **`03_os_scan.png`** | Terminal window showing the command execution and results of:<br>`sudo nmap -O TARGET_IP -oN os_scan.txt` |

---

### How to Capture Screenshots in Linux (Kali / Ubuntu)

You can use any of the following standard screenshot utilities available on your Linux VM:

1. **XFCE Screenshot Utility (Default in Kali Linux)**:
   - Press the **`Print Screen`** (PrtScn) key on your keyboard.
   - Or open the terminal and type:
     ```bash
     xfce4-screenshooter
     ```
   - Select **Active window** or **Select a region**, capture your terminal, and save the file with the specified filename into this `screenshots/` directory.

2. **Flameshot (Feature-rich screenshot tool)**:
   - Install if needed:
     ```bash
     sudo apt update && sudo apt install flameshot -y
     ```
   - Launch:
     ```bash
     flameshot gui
     ```
   - Select the terminal area and save directly to `screenshots/01_basic_scan.png`.

3. **GNOME Screenshot (Ubuntu Default)**:
   - Press **`Shift + PrtScn`** to select an area, or run:
     ```bash
     gnome-screenshot -a
     ```

4. **Host Operating System (Windows)**:
   - If running Kali inside VirtualBox or VMware on Windows:
     - Use **`Windows + Shift + S`** (Snipping Tool).
     - Select your VM terminal window.
     - Save the image directly to `CyberSecurity-Task1-Nmap/screenshots/` on your host.

---

### Best Practices for Evaluator Review
- Ensure the terminal text is sharp and legible (zoom in terminal font with `Ctrl + Shift + +` if necessary).
- Keep the terminal prompt, entered command, and execution results clearly visible in each frame.
- Verify that filenames are in lowercase and match the `.png` extension exactly.
