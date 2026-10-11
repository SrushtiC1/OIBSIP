# Demonstration Video Recording Guide
## Oasis Infobyte Cyber Security Internship — Task 1: Basic Network Scanning with Nmap

This comprehensive guide outlines how to record and present an exceptional, professional 2-to-4 minute video demonstration for submission to Oasis Infobyte.

---

### 1. Required Video Title Card (First 2–3 Seconds)

Oasis Infobyte evaluation guidelines recommend starting your video with a clear intro slide or text title card displayed prominently on screen for at least **2 to 3 seconds**.

You can create this slide using PowerPoint, Canva, or a text editor in full screen:

```text
========================================================================
                      OASIS INFOBYTE (OIBSIP)
                CYBER SECURITY INTERNSHIP PROGRAM

  Task 1: Basic Network Scanning with Nmap
  Domain: Network Reconnaissance & Security Auditing
  Intern Name: [Your Full Name]
  Internship Track: Cyber Security
  Batch / Month: [e.g., September - October 2026]
========================================================================
```

> [!TIP]
> You can also display this title card directly in your terminal using `cat` or in a slide presentation before switching to the terminal window.

---

### 2. Suggested 2–4 Minute Recording Structure

| Timestamp | Phase / Segment | Visual on Screen | Key Activity |
| :---: | :--- | :--- | :--- |
| **0:00 – 0:05** | **Title Card & Greeting** | Title card slide / banner | State your name, organization (Oasis Infobyte), and task objective. |
| **0:05 – 0:40** | **Environment & Scope Setup** | Terminal / VirtualBox / VMware | Show the isolated lab setup. Display target IP discovery (`ip a` or ping). Emphasize authorized local testing. |
| **0:40 – 1:15** | **Basic Port Scan** | Kali Linux Terminal | Type and run `nmap TARGET_IP -oN basic_scan.txt`. Explain what a TCP port scan does and highlight open ports. |
| **1:15 – 1:55** | **Service Version Scan** | Kali Linux Terminal | Type and run `nmap -sV TARGET_IP -oN service_scan.txt`. Explain the `-sV` flag and highlight detected service versions. |
| **1:55 – 2:35** | **OS Detection Scan** | Kali Linux Terminal | Type and run `sudo nmap -O TARGET_IP -oN os_scan.txt`. Explain `-O` and TCP/IP stack fingerprinting. |
| **2:35 – 3:30** | **Results & Analysis Review** | VS Code / Antigravity / Text Editor | Show the generated output files (`basic_scan.txt`, `service_scan.txt`, `os_scan.txt`), and walk through `nmap_scan_results.txt` and `README.md`. |
| **3:30 – 3:50** | **Conclusion & Ethics Statement** | Final summary slide / GitHub repo | Summarize defensive takeaways (least privilege, patching) and conclude with an ethical hacking disclaimer. |

---

### 3. Step-by-Step Narration Script

Use this sample script as a speaking guide during your screen recording:

#### Introduction (0:00 – 0:25)
> *"Hello everyone! My name is [Your Name], and I am a Cyber Security intern at Oasis Infobyte. Today, I am presenting Task 1 of Level 1: Basic Network Scanning with Nmap. The objective of this project is to perform an authorized, controlled network scan of an isolated local target virtual machine, identify open ports and active services, attempt operating system detection, and analyze the resulting security considerations."*

#### Lab Scope & Ethical Statement (0:25 – 0:45)
> *"Before we begin, here is an important ethical notice: this scan is being conducted strictly within an isolated private lab network using non-routable RFC 1918 IP addresses. Scanning public hosts or unauthorized systems is strictly illegal and unethical. My target is an authorized local virtual machine with IP address [mention your target IP, e.g., 192.168.56.101]."*

#### Scan 1: Basic TCP Port Scan (0:45 – 1:20)
> *"First, let's run our basic TCP port scan. I run `nmap [TARGET_IP] -oN basic_scan.txt`. This probes the 1,000 most common TCP ports. As we can see on screen, the scan completes and identifies open ports such as [mention ports, e.g., Port 22 SSH and Port 80 HTTP]. The results are automatically saved to `basic_scan.txt`."*

#### Scan 2: Service & Version Detection Scan (1:20 – 2:00)
> *"Next, to identify what specific software and versions are running behind these open ports, we run `nmap -sV [TARGET_IP] -oN service_scan.txt`. Nmap queries its signature database and performs banner grabbing. Here in the output, we see [mention software versions, e.g., OpenSSH 8.2p1 and Apache httpd 2.4.41]. This is critical for defenders because outdated software versions can expose systems to known CVEs."*

#### Scan 3: Operating System Detection (2:00 – 2:40)
> *"Now, we attempt remote operating system identification using `sudo nmap -O [TARGET_IP] -oN os_scan.txt`. We use sudo because OS detection crafts raw network packets to examine subtle differences in how the target's TCP/IP stack responds. Looking at the results, Nmap fingerprints the target as [mention OS result, e.g., Linux 5.4.x / Ubuntu]."*

#### Documentation & Security Analysis (2:40 – 3:30)
> *"Switching to our project workspace, all outputs are cleanly captured in `basic_scan.txt`, `service_scan.txt`, and `os_scan.txt`. In our assessment report `nmap_scan_results.txt`, we have documented each service, analyzed its security risks, and outlined recommended remediations—such as disabling unneeded services, binding management ports to localhost, and enabling firewall rules."*

#### Conclusion (3:30 – 3:50)
> *"In conclusion, Nmap provides crucial visibility into an organization's attack surface. Understanding open ports and active services allows security professionals to harden systems proactively. Thank you Oasis Infobyte for this learning opportunity!"*

---

### 4. Screen Recording Setup Instructions

#### Option A: OBS Studio (Recommended for Windows / Linux)
1. **Download & Install**: Free from [obsproject.com](https://obsproject.com/).
2. **Video Settings**:
   - Go to **Settings > Video**.
   - Base (Canvas) Resolution: `1920x1080` (or your native display resolution).
   - Output (Scaled) Resolution: `1920x1080`.
   - Common FPS Values: `30` or `60`.
3. **Sources**:
   - In the **Sources** box, click the `+` button.
   - Choose **Display Capture** (captures entire screen) or **Window Capture** (captures only the terminal or VM window).
4. **Audio Settings**:
   - Ensure your microphone is selected in **Settings > Audio > Mic/Auxiliary Audio**.
   - Check the audio meter to ensure your voice levels stay in the yellow zone (between -20 dB and -6 dB) without clipping.
5. **Recording**:
   - Click **Start Recording**, conduct your demo, and click **Stop Recording**.
   - Output file is usually saved in your `Videos` folder as an `.mp4` or `.mkv` file.

#### Option B: Windows Native Game Bar (Windows 10/11)
- Press **`Windows Key + Alt + R`** to start/stop screen recording.
- Toggle microphone with **`Windows Key + Alt + M`**.

#### Option C: SimpleScreenRecorder (Inside Kali Linux)
```bash
sudo apt update && sudo apt install simplescreenrecorder -y
simplescreenrecorder
```
Follow the wizard, select fullscreen, configure audio, and record directly inside the VM.

---

### 5. Final Checklist Before Publishing

Before posting your task video to LinkedIn, YouTube, or the Oasis Infobyte submission form, verify:

- [ ] **Title Card Displayed**: The first 2–3 seconds clearly display your full name, task title, track, and Oasis Infobyte.
- [ ] **Legible Font**: Terminal commands and scan outputs are easy to read (zoom in with `Ctrl + Shift + +` if needed).
- [ ] **Clear Audio**: Speech is clear without distracting background noise or echo.
- [ ] **Scope Adherence**: Only local private lab IP addresses are shown; no external or public websites are scanned.
- [ ] **Duration**: Video duration is between **2 and 4 minutes**.
- [ ] **Video Format**: Exported as `.mp4` for maximum compatibility.
- [ ] **Upload & Sharing**:
  - If sharing on **LinkedIn**: Tag `@Oasis Infobyte`, mention `#cybersecurity #internship #nmap #infosec #oibsip`, and include your GitHub repository link.
  - If sharing on **YouTube**: Set visibility to **Unlisted** or **Public**, and include the GitHub repository link in the description.
