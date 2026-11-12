# Evidence Capture Guide: Screenshots for Task 2

This folder stores authentic visual evidence of the UFW configuration, rule verification, and testing procedures performed on your Kali Linux virtual machine.

> [!WARNING]
> **Academic Integrity Notice:**  
> Never generate, forge, or fabricate screenshots or terminal outputs. Authentic internship evaluations require genuine evidence generated directly from your virtual machine environment. If a test cannot be performed (e.g., lacking a second VM), document the limitation honestly in `testing_notes.md`.

---

## Required Screenshots Checklist

Capture the following screenshots and save them into this `screenshots/` directory:

| Filename | Purpose / Terminal Command | What Must Be Visible |
| :--- | :--- | :--- |
| `01_ufw_installation_check.png` | `ufw --version` or `which ufw` | Shows UFW installed and ready on your Kali Linux system. |
| `02_script_execution.png` | `sudo ./ufw_configuration.sh` | Shows the script execution, safety warning, user prompt `[y/N]`, and the rules being applied step-by-step. |
| `03_ufw_status_verbose.png` | `sudo ufw status verbose` | Shows `Status: active`, Default incoming: `deny`, Default outgoing: `allow`, and the active rule table (ports 22, 80, 443, 23). |
| `04_http_service_listening.png` | `sudo python3 -m http.server 80` & `sudo ss -tlpn \| grep :80` | Shows the temporary Python HTTP server actively running and bound to port 80. |
| `05_http_deny_test_result.png` | `curl -m 5 -v http://<KALI_IP>` *(from client VM/host)* | Shows connection timing out or being filtered while the server in `04` is running. *(Mark as not captured if single VM)* |

---

## How to Capture Crisp, Professional Screenshots

1. **Keep Context Visible**:
   - Ensure the terminal prompt is clearly legible (`kali@kali` or `root@kali`), showing who executed the command.
   - Include the command line alongside its output in the frame.

2. **Windows Snipping Tool / VMware Screen Capture**:
   - Press `Windows Key + Shift + S` on your Windows host to take a rectangular snip of the VMware terminal window.
   - Alternatively, inside Kali Linux, use the native screenshot tool (`xfce4-screenshooter` or press the `Print Screen` key).

3. **File Naming & Formats**:
   - Save all images as PNG format using the exact filenames listed in the table above:
     - `screenshots/01_ufw_installation_check.png`
     - `screenshots/02_script_execution.png`
     - `screenshots/03_ufw_status_verbose.png`
     - `screenshots/04_http_service_listening.png`
     - `screenshots/05_http_deny_test_result.png`
