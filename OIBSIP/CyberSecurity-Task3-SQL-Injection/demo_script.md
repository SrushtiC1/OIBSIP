# Presentation Script: Task 3 SQL Injection Testing

**Target length:** 2–3 minutes. Replace the bracketed prompts only with facts and observations from your own lab. If tests have not been run, say so; do not present expected behavior as an actual result.

## Introduction

Hello, this is my internship project, **Task 3: SQL Injection Testing in a Local DVWA Lab**. The goal is to understand how unsafe handling of input can affect database queries and to learn how developers prevent SQL injection. This demonstration is restricted to a deliberately vulnerable DVWA instance on my own computer. No public website, third-party system, or real account is involved.

## Local lab setup

I used XAMPP for the local Apache web server, PHP, and MySQL-compatible database service, and DVWA as the intentionally vulnerable training application. I initialized DVWA's own lab database and selected the Low security level for the documented demonstration. The vulnerable service is not exposed to the internet.

## Test procedure and observations

First, I submitted the normal input from test case TC-01: `[input]`. I observed: `[describe only what your browser displayed, or say “not run”]`.

Next, in DVWA's SQL Injection module only, I used the read-only demonstration input recorded in TC-02. The expected behavior in this training scenario is that the input may alter the query condition and return more than one synthetic DVWA record. My actual observation was: `[report your measured result, or say “not run”]`. This statement is about this local test only, not about any other application.

Finally, I submitted the invalid input in TC-03. I observed: `[report the actual page response, or say “not run”]`. The expected outcomes in my notes are predictions, not test evidence. I recorded test status only after performing each test.

## Remediation and conclusion

The main prevention is to use prepared statements and parameterized queries so user input remains data rather than becoming SQL syntax. Developers should also validate inputs, use database accounts with least privilege, return safe error messages, protect credentials, and keep vulnerable training software isolated.

This local exercise shows why secure query handling matters and how to document a test honestly. DVWA is intentionally vulnerable, so I stopped the local services after testing. Thank you.

## Recording reminder

Before recording or sharing, hide passwords, browser-saved credentials, session cookies, tokens, personal files, and any other private information. Show only genuine screenshots and actual observations from your own lab. Do not claim that a test passed if it has not been performed.
