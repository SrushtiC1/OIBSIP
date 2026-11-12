# Project Demonstration Video Guide & Narration Script

**Project**: Oasis Infobyte Cyber Security Internship (OIBSIP)  
**Task 2**: Basic Firewall Configuration with UFW  
**Duration**: 2 to 3 Minutes  
**Software**: OBS Studio (Windows Host) capturing Kali Linux (VMware VM)

---

## Part 1: OBS Studio Recording Setup (Windows Host)

To record a clean, professional demonstration video:

1. **Install OBS Studio**:
   - Download free from [obsproject.com](https://obsproject.com/) if not already installed on Windows.
2. **Add Video Source**:
   - Under **Sources**, click `+` and choose **Window Capture**.
   - Select your VMware Workstation / Player window (Kali Linux).
   - If Window Capture shows a black screen, choose **Display Capture** instead and crop to the VMware window.
3. **Configure Audio**:
   - Ensure your microphone is active under **Audio Mixer**.
   - Speak a few test sentences and verify the green/yellow volume meter responds.
4. **Video Resolution & Terminal Sizing**:
   - Set Kali Linux terminal font to a comfortable, readable size (`Ctrl + Shift + +` in Kali terminal).
   - Maximize or size VMware comfortably so text is crisp at 1080p.

---

## Part 2: Quick Checklist Before Pressing "Start Recording"

- [ ] Kali Linux VM is open in VMware.
- [ ] Terminal is open in the project folder `CyberSecurity-Task2-UFW`.
- [ ] You have root access or sudo password handy.
- [ ] OBS Studio is recording the correct window/display and audio levels are healthy.
- [ ] You have rehearsed the script below once or twice.

---

## Part 3: Video Demonstration Timeline & Narration Script

### Scene 1: Introduction & Lab Scope (0:00 – 0:35)
**Visual on Screen**: Title slide or terminal window displaying your project folder and student name.

> **Spoken Narration:**  
> *"Hello everyone! My name is [Your Name], and I am a Cyber Security Intern at Oasis Infobyte.  
> Today, I will be demonstrating Task 2 of the internship: Basic Firewall Configuration with UFW — the Uncomplicated Firewall on Linux.  
> In this lab, my host machine is running Windows, and I am using VMware Workstation to run an isolated Kali Linux virtual machine.  
> Our primary goal is to establish a secure default-deny firewall policy, allow necessary management traffic like SSH and HTTPS, and block unencrypted, risky protocols like HTTP and Telnet."*

---

### Scene 2: Script Overview & Execution (0:35 – 1:20)
**Visual on Screen**: Display the bash script `ufw_configuration.sh` briefly using `cat` or `head`, then execute it with `sudo ./ufw_configuration.sh`.

**Action in Terminal:**
```bash
sudo ./ufw_configuration.sh
```
*(When prompted with `Do you want to proceed with applying these firewall rules? [y/N]:`, type `y` and press Enter).*

> **Spoken Narration:**  
> *"To ensure repeatable and secure deployment, I developed an automated Bash script called `ufw_configuration.sh`.  
> Notice that the script first performs safety checks: it verifies root privileges, ensures UFW is installed, displays any existing firewall rules, and pauses for explicit user confirmation before touching the firewall table.  
> I’ll confirm with 'yes'.  
> As you can see, the script sets our baseline policies: default deny incoming, default allow outgoing.  
> It then creates rules to allow incoming SSH on TCP port 22 and HTTPS on port 443, while explicitly denying HTTP on port 80 and legacy Telnet on port 23.  
> Only after staging all rules does the script enable UFW, preventing accidental administrative lockouts."*

---

### Scene 3: Verification of Active Rules (1:20 – 1:55)
**Visual on Screen**: Running `sudo ufw status verbose` and reviewing the output table.

**Action in Terminal:**
```bash
sudo ufw status verbose
```

> **Spoken Narration:**  
> *"Now let’s verify the active state using `sudo ufw status verbose`.  
> Here we can see:  
> - Status is **active**.  
> - Default incoming policy is **deny**, enforcing the security principle of least privilege.  
> - Default outgoing policy is **allow**, ensuring the system can reach package mirrors and DNS.  
> - In our rules table, TCP port 22 and 443 are **ALLOWED IN**, while TCP port 80 and 23 are **DENIED IN** from anywhere.  
> I have also exported this output to `ufw_rules_output.txt` for technical evaluation."*

---

### Scene 4: Testing & Causality Verification (1:55 – 2:35)
**Visual on Screen**: Splitting terminal or demonstrating the controlled HTTP test setup.

**Action in Terminal:**
```bash
# Terminal 1 (Target):
sudo python3 -m http.server 80

# Terminal 2 (Verification of listener):
sudo ss -tlpn | grep :80
```

> **Spoken Narration:**  
> *"A crucial concept in cybersecurity testing is verifying causality. Simply showing a failed connection doesn't prove a firewall works — if no service is running, the operating system would refuse connections anyway!  
> To conduct a true scientific test, I spin up a temporary Python HTTP server on port 80 and verify with `ss` that port 80 is in an active `LISTEN` state.  
> When a client attempts to connect to port 80, the request is filtered and dropped by UFW, proving that our firewall rule is actively protecting the endpoint.  
> Once verified, I terminate the test server."*

---

### Scene 5: Conclusion & Ethical Compliance (2:35 – 3:00)
**Visual on Screen**: Closing remarks / returning to project directory view.

> **Spoken Narration:**  
> *"All activities in this demonstration were performed strictly inside an isolated virtual lab environment on private subnets.  
> In conclusion, by configuring UFW with a default-deny posture and strict inbound access control, we significantly reduce the attack surface of our Linux host.  
> Thank you to Oasis Infobyte for this practical hands-on task, and thank you for watching!"*

---

## Part 4: Post-Recording Submission Tips
1. Review your video replay to confirm your voice is clear and the terminal text is easily legible.
2. Upload the video to LinkedIn or your designated project drive/YouTube (unlisted or public) as requested by the Oasis Infobyte submission guidelines.
3. Include your GitHub repository link and task description in your submission post!
