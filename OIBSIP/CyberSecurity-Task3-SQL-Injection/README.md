# Task 3: SQL Injection Testing in a Local DVWA Lab

> **Internship Project | Cybersecurity Domain**  
> **Platform:** DVWA (Damn Vulnerable Web Application) running locally via XAMPP  
> **Scope:** Local lab environment only — no external or public systems

---

## ⚠️ Safety Notice

This project is conducted **entirely on your own computer** using a deliberately vulnerable application designed for educational purposes.

- ✅ Only test against your local DVWA installation.
- ❌ Never test against public websites, third-party systems, or real accounts.
- ❌ Never run destructive SQL commands (`DROP`, `DELETE`, `TRUNCATE`) in any real database.
- ❌ Never share credentials, logs, or screenshots containing private data.
- ❌ Do not claim test results unless you have personally verified them in your lab.

---

## Table of Contents

1. [Objective](#1-objective)
2. [What is SQL Injection?](#2-what-is-sql-injection)
3. [What is DVWA?](#3-what-is-dvwa)
4. [What is XAMPP?](#4-what-is-xampp)
5. [Software Requirements](#5-software-requirements)
6. [Local Setup Instructions](#6-local-setup-instructions)
7. [Accessing DVWA](#7-accessing-dvwa)
8. [Configuring the Security Level](#8-configuring-the-security-level)
9. [Test Procedure](#9-test-procedure)
10. [Documenting Results](#10-documenting-results)
11. [Security Precautions](#11-security-precautions)
12. [Conclusion](#12-conclusion)
13. [References](#13-references)

---

## 1. Objective

The objective of this task is to:

- Understand how SQL Injection vulnerabilities arise in web applications.
- Practice identifying SQL injection in a safe, controlled, local lab environment.
- Document test cases, observations, and findings following a structured methodology.
- Learn and apply remediation techniques to prevent SQL injection attacks.

This project is part of a college cybersecurity internship and follows ethical and legal guidelines.

---

## 2. What is SQL Injection?

**SQL Injection (SQLi)** is a type of web application security vulnerability where an attacker is able to interfere with the queries that an application sends to its database.

### How it works

Web applications typically use user-supplied input to build SQL queries dynamically. For example, a login form might construct a query like:

```sql
SELECT * FROM users WHERE username = 'alice' AND password = 'secret';
```

If the application does **not** properly validate or sanitize user input, an attacker can manipulate the query by entering specially crafted input. For example, entering:

```
' OR '1'='1
```

Could transform the query into:

```sql
SELECT * FROM users WHERE username = '' OR '1'='1' AND password = '';
```

Because `'1'='1'` is always true, this may bypass authentication entirely.

### Potential Impact

| Risk | Description |
|------|-------------|
| **Data Exposure** | Attackers can read sensitive database contents |
| **Authentication Bypass** | Log in without valid credentials |
| **Data Manipulation** | Insert, update, or delete records |
| **Privilege Escalation** | Gain administrative access |
| **Server Compromise** | In some cases, execute OS commands |

SQL Injection has consistently appeared in the **OWASP Top 10** list of critical web application security risks.

---

## 3. What is DVWA?

**DVWA (Damn Vulnerable Web Application)** is a PHP/MySQL web application that is intentionally designed with security vulnerabilities. It is used by security professionals, educators, and students to:

- Practice common web attack techniques in a legal and controlled environment.
- Learn how vulnerabilities function from both an attacker's and a developer's perspective.
- Prepare for certifications and real-world penetration testing engagements.

DVWA includes modules for:
- SQL Injection
- XSS (Cross-Site Scripting)
- CSRF (Cross-Site Request Forgery)
- File Inclusion
- Command Injection
- Brute Force
- ...and more

**Official Repository:** https://github.com/digininja/DVWA

> DVWA must only be run on a local machine or isolated internal network. Never expose it to the public internet.

---

## 4. What is XAMPP?

**XAMPP** is a free, open-source software package developed by Apache Friends. It bundles together:

| Component | Purpose |
|-----------|---------|
| **Apache** | Web server (serves PHP pages) |
| **MariaDB / MySQL** | Database server (stores application data) |
| **PHP** | Server-side scripting language |
| **phpMyAdmin** | Web-based database administration tool |

XAMPP makes it easy to run a complete local web server environment on Windows without complex manual installation. DVWA runs on top of XAMPP.

---

## 5. Software Requirements

| Software | Version Recommended | Download Link |
|----------|-------------------|---------------|
| XAMPP | Latest stable (PHP 8.x) | https://www.apachefriends.org/download.html |
| DVWA | Latest from GitHub | https://github.com/digininja/DVWA |
| Web Browser | Chrome, Firefox, or Edge | Pre-installed |
| Git (optional) | For cloning DVWA | https://git-scm.com/ |
| Text Editor | VS Code or Notepad++ | For editing config files |

**Operating System:** Windows 10 / Windows 11

---

## 6. Local Setup Instructions

Follow these steps carefully. Each step must be completed before moving to the next.

### Step 1 — Install XAMPP

1. Download the XAMPP installer from https://www.apachefriends.org/download.html.
2. Run the installer. Accept the default options unless you have a specific reason to change them.
3. Install XAMPP to the default path: `C:\xampp\`.
4. Once installed, open the **XAMPP Control Panel** from the Start menu or desktop shortcut.

### Step 2 — Start Apache and MySQL

1. Open the XAMPP Control Panel.
2. Click **Start** next to **Apache**.
3. Click **Start** next to **MySQL**.
4. Both services should show a green status and their port numbers (Apache: 80, MySQL: 3306).
5. If port 80 is occupied (by IIS or Skype), refer to `testing_notes.md` for troubleshooting.

### Step 3 — Download DVWA

**Option A — Using Git (recommended):**
```bash
cd C:\xampp\htdocs
git clone https://github.com/digininja/DVWA.git dvwa
```

**Option B — Manual download:**
1. Go to https://github.com/digininja/DVWA.
2. Click **Code → Download ZIP**.
3. Extract the ZIP file.
4. Copy the extracted folder into `C:\xampp\htdocs\` and rename it to `dvwa`.

### Step 4 — Configure DVWA

1. Navigate to `C:\xampp\htdocs\dvwa\config\`.
2. Copy `config.inc.php.dist` and rename the copy to `config.inc.php`.
3. Open `config.inc.php` in a text editor.
4. Verify or update the following settings:

```php
$_DVWA[ 'db_server' ]   = '127.0.0.1';
$_DVWA[ 'db_database' ] = 'dvwa';
$_DVWA[ 'db_user' ]     = 'dvwa';
$_DVWA[ 'db_password' ] = 'REPLACE_WITH_YOUR_LOCAL_LAB_PASSWORD';
$_DVWA[ 'db_port']      = '3306';
```

> **Note:** Replace the password placeholder with a password chosen only for this local lab. Do not use personal, school, or production credentials. Keep `config.inc.php` out of version control.

### Step 5 — Create the DVWA Database User

1. Open phpMyAdmin at http://localhost/phpmyadmin.
2. Log in using the local XAMPP database administrator account configured on your computer. Do not assume a blank password; use the credentials you set during installation.
3. Click the **SQL** tab and run:

```sql
CREATE DATABASE dvwa;
CREATE USER 'dvwa'@'127.0.0.1' IDENTIFIED BY 'REPLACE_WITH_YOUR_LOCAL_LAB_PASSWORD';
GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'127.0.0.1';
FLUSH PRIVILEGES;
```

4. Confirm the database `dvwa` appears in the left sidebar.

### Step 6 — Initialize DVWA

1. Go to http://localhost/dvwa/setup.php in your browser.
2. Scroll to the bottom and click **Create / Reset Database**.
3. DVWA will confirm that the database has been initialized.
4. You will be redirected to the login page.

---

## 7. Accessing DVWA

1. Open your browser.
2. Navigate to: **http://localhost/dvwa/**
2. Log in with the credentials documented by the official DVWA project for your installed version, or the credentials you configured. Change default credentials where supported and never reuse a real account password.

---

## 8. Configuring the Security Level

1. After logging in, click **DVWA Security** in the left sidebar.
2. Select **Low** from the dropdown menu.
3. Click **Submit**.

| Security Level | Description |
|---------------|-------------|
| **Low** | No input validation. Ideal for learning basic SQL injection. |
| **Medium** | Some server-side filtering applied. |
| **High** | Stricter protections. Challenges advanced techniques. |
| **Impossible** | Secure implementation used as a reference. |

> Begin with **Low** to understand how the vulnerability works.

---

## 9. Test Procedure

### Navigate to the SQL Injection Module

1. In the DVWA sidebar, click **SQL Injection**.
2. You will see a form with a **User ID** field.

### Test Case Overview

Detailed test cases are documented in `sql_injection_notes.md`.

| Test ID | Description | Input |
|---------|------------|-------|
| TC-01 | Normal valid input | `1` |
| TC-02 | SQL injection demonstration (harmless) | `1' OR '1'='1` |
| TC-03 | Invalid / non-existent input | `999` |

### General Steps for Each Test

1. Enter the test input in the **User ID** field.
2. Click **Submit**.
3. Observe and record the application's response.
4. Take a screenshot and save it to the `screenshots/` folder.
5. Fill in the **Actual Observation** and **Status** in `sql_injection_notes.md`.

> **Important:** Record only what you genuinely observe. Do not fill in expected results as actual results.

---

## 10. Documenting Results

An **expected result** is a prediction to compare against; it is not evidence that a test ran. An **actual observation** is only what you personally saw in your local browser after performing the test. Leave it blank until then.

For each test case, document:
- The exact input you entered.
- The exact response displayed by DVWA.
- Whether the result matched expected behavior.
- Status: **Passed**, **Failed**, **Not Run**, or **Inconclusive**.
- The screenshot filename.

---

## 11. Security Precautions

| Precaution | Why It Matters |
|-----------|---------------|
| Run DVWA only on localhost | Prevents outsiders from accessing the vulnerable app |
| Do not use real personal data | Protects your privacy |
| Stop XAMPP services when not testing | Reduces your local attack surface |
| Never expose XAMPP to the internet | DVWA is intentionally vulnerable |
| Keep test credentials separate | Avoid reusing lab passwords in real accounts |
| Do not run destructive SQL commands | Preserves the DVWA database for repeated testing |

---

## 12. Conclusion

After you perform and document the tests, use the results to explain how SQL injection can arise from unsafe query construction and how it can be assessed in a controlled environment. Keep the lab local and isolated; no activity is risk-free if a vulnerable service is exposed beyond the intended machine.

The remediation techniques in `remediation.md` — particularly **prepared statements** and **parameterized queries** — are industry-standard defenses that prevent SQL injection in production applications.

---

## 13. References

- DVWA Official Repository: https://github.com/digininja/DVWA
- OWASP SQL Injection: https://owasp.org/www-community/attacks/SQL_Injection
- OWASP SQL Injection Prevention Cheat Sheet: https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html
- OWASP Top 10: https://owasp.org/www-project-top-ten/
- XAMPP Official Site: https://www.apachefriends.org/
- PortSwigger SQL Injection Guide: https://portswigger.net/web-security/sql-injection

---

*This project is a learning guide. It does not claim that DVWA was installed or that any test was run. Record completion and results only after you perform the work in your own local lab.*
