# Network Security Threats — Research & Analysis Report

## Oasis Infobyte Cyber Security Internship (OIBSIP)
### Task 4: Common Network Security Threats

---

## 📌 Project Overview

This repository houses the comprehensive technical research report prepared for **Task 4** of the **Oasis Infobyte Cyber Security Internship**. The objective of this project is to conduct an in-depth, rigorous academic and practical evaluation of common network security threats that compromise the confidentiality, integrity, and availability of digital infrastructures.

Rather than conducting simulated attacks or penetration testing, this project focuses on technical research, protocol-level vulnerability analysis, forensic examination of historical incidents, and engineering defensible mitigation architectures for modern network administrators.

🔗 **Deliverable Link:**  
👉 **[Read the Complete Network Security Threats Report](network_security_threats_report.md)**

---

## 🎯 Project Objectives

1. **Deconstruct Network Vulnerabilities:** Analyze the fundamental architectural and protocol weaknesses (e.g., statelessness, lack of native source authentication) within the core TCP/IP protocol suite that threat actors exploit.
2. **Examine Attack Execution Mechanisms:** Trace step-by-step technical workflows for Denial of Service, Distributed Denial of Service, Adversary-in-the-Middle, IP Address Spoofing, and DNS Cache Poisoning.
3. **Review Real-World Blast Radiuses:** Investigate verified historical cybersecurity incidents and disclosed vulnerabilities with concrete dates, operational impacts, and forensic details.
4. **Formulate Defensible Mitigations:** Detail at least three practical, industry-standard mitigation strategies for each threat category, referencing established cybersecurity standards and RFC benchmarks.
5. **Synthesize Administrative Takeaways:** Provide network administrators with actionable architectural imperatives centered on defense-in-depth, continuous telemetry monitoring, and structured incident response.

---

## 🛡️ Topics Covered

The primary research report provides detailed coverage of the following threat vectors:

1. **Denial of Service (DoS) and Distributed Denial of Service (DDoS)**
   - Theoretical foundations, resource exhaustion targets (CPU, bandwidth, socket state tables).
   - Architectural differentiation: DoS vs. botnet-orchestrated DDoS.
   - Attack taxonomies: Volumetric (UDP/ICMP), Protocol-level (TCP SYN floods), Application-layer (HTTP GET/POST, Slowloris).
   - Case Study: The 1.35 Tbps Memcached amplification attack against GitHub (February 2018).
   - Defenses: Rate limiting, SYN cookies, Anycast cloud-scrubbing providers, and infrastructure redundancy.
2. **Man-in-the-Middle (MITM) / Adversary-in-the-Middle (AiTM)**
   - Positioning vectors: ARP poisoning, Rogue Wi-Fi APs ("Evil Twins"), DNS hijacking, and reverse-proxy phishing (e.g., Evilginx2).
   - Case Study: The DigiNotar Certificate Authority compromise and rogue `*.google.com` certificates (2011).
   - Cryptographic impacts on confidentiality, integrity, and first-generation MFA bypass.
   - Defenses: TLS 1.3, HSTS preloading, Dynamic ARP Inspection (DAI), 802.1X, and FIDO2/WebAuthn hardware authentication (with analysis of VPN protection capabilities and limitations).
3. **IP Address Spoofing**
   - Packet crafting mechanics, raw sockets (`SOCK_RAW`), and the stateless nature of IPv4 routing.
   - Adversary objectives: Anti-attribution, access-control evasion, and asymmetric reflection.
   - Mathematical amplification dynamics in UDP reflection attacks (DNS, NTP, Memcached).
   - Case Study: IP spoofing as the technical foundation of the 2018 GitHub Memcached DDoS incident.
   - Defenses: IETF BCP 38 / RFC 2827 ingress filtering, Unicast Reverse Path Forwarding (uRPF - Strict and Loose modes), and egress filtering.
4. **Bonus Topic: DNS Poisoning and DNS Spoofing**
   - Normal hierarchical resolution and caching dynamics across stub, recursive, and authoritative name servers.
   - Race conditions, transaction ID (TXID) guessing, and cache injection mechanics.
   - Case Study: Dan Kaminsky’s cache poisoning vulnerability (CVE-2008-1447) and birthday attacks.
   - Defenses: DNS Security Extensions (DNSSEC) origin authentication and integrity, UDP source port randomization (RFC 5452), Protective DNS (PDNS), and encrypted DNS transport protocols (DoH, DoT, DoQ) along with the vital clarification that transport encryption does not replace DNSSEC.
5. **Comparative Threat Matrix**
   - Structured comparison analyzing Attack Vector, Who Is at Risk, Difficulty to Execute, and Ease of Mitigation.
6. **Strategic Administrator Takeaways**
   - Key imperatives focusing on Defense in Depth, Continuous Telemetry & Patching, and Incident Response & Awareness.

---

## 📁 Repository Structure

```
CyberSecurity-Task4-Network-Security-Threats/
│
├── network_security_threats_report.md    # Full comprehensive technical research report
└── README.md                             # Project documentation, overview, and navigation
```

---

## 🔬 Research Methodology & Analytical Framework

This research project adheres to rigorous academic and technical documentation standards:
* **Protocol-Level Deconstruction:** Evaluating RFC protocol specifications (IETF) to pinpoint design assumptions that enable modern exploitation.
* **Evidence-Based Incident Analysis:** Utilizing authoritative first-party engineering disclosures, post-mortems, and security vendor bulletins rather than secondary journalistic conjecture.
* **Standards-Based Countermeasures:** Mapping all defensive recommendations to internationally recognized guidelines published by NIST, CISA, MITRE, and the IETF.
* **Clear Conceptual Boundaries:** Maintaining technical precision (e.g., explicitly separating the role of IP spoofing as an enabler from the resulting DDoS attack; distinguishing DNSSEC data integrity from transport encryption).

---

## 📚 Reference-Source Categories

The research draws from authoritative cybersecurity bodies, standards institutions, and verified organizational disclosures:

* **Standards Organizations:** National Institute of Standards and Technology (NIST SP 800-81 Rev. 3), Internet Engineering Task Force (IETF RFC 2827 / BCP 38, RFC 5452).
* **Government Cybersecurity Agencies:** Cybersecurity and Infrastructure Security Agency (CISA), Canadian Centre for Cyber Security (CCCS ITSAP.40.021).
* **Threat Intelligence & Classification Frameworks:** MITRE ATT&CK Enterprise Matrix (Technique T1557: Adversary-in-the-Middle).
* **Official First-Party Disclosures & Advisory Bulletins:** GitHub Engineering Incident Reports, Google Online Security Blog disclosures, Internet Systems Consortium (ISC Knowledge Base).

---

## 🛠️ Tools and Technologies

* **Documentation & Formatting:** Markdown (GitHub Flavored Markdown - GFM)
* **Version Control:** Git, GitHub
* **Frameworks & Authoritative Standards:**
  - NIST (National Institute of Standards and Technology)
  - CISA (Cybersecurity and Infrastructure Security Agency)
  - MITRE ATT&CK Knowledge Base
  - IETF (Internet Engineering Task Force) RFC Standards
  - ISC (Internet Systems Consortium)

---

## 👤 Author Information

* **Researcher:** Srushti Dayanand Chougale
* **Department:** Computer Science and Engineering (Artificial Intelligence and Machine Learning)
* **Internship Program:** Oasis Infobyte Cyber Security Internship (OIBSIP)
* **Domain:** Cyber Security
* **Task:** Task 4 — Common Network Security Threats
* **Academic Year:** 2026–2027

---

*This project is submitted as an official academic deliverable for the Oasis Infobyte Cyber Security Internship.*

