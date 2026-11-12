# Local DVWA Testing Notes

Use this checklist with the setup guide in `README.md`. It is a record of steps to perform, not evidence that any step has been completed. Write down only results you personally observe.

## Before testing

- [ ] Confirm DVWA is installed under the local XAMPP web root and configured using the official DVWA project instructions.
- [ ] Confirm the lab contains only the synthetic data created by DVWA setup. Do not add real or personal data.
- [ ] Keep the vulnerable service on this computer. Do not port-forward it, expose it to the internet, or test a public host.
- [ ] Open the XAMPP Control Panel.
- [ ] Start **Apache** and confirm the panel reports it running.
- [ ] Start **MySQL** (XAMPP commonly bundles MariaDB) and confirm the panel reports it running.
- [ ] Visit `http://localhost/` and confirm the local web server responds.
- [ ] Visit `http://localhost/dvwa/setup.php` and check the setup page's requirements and database status.
- [ ] If this is a new installation, use DVWA's **Create / Reset Database** control once to initialize its lab database. This action resets DVWA's own data; verify the page and configured database before clicking. Never run database reset/setup actions against another database.
- [ ] Log in to DVWA using the credentials for your local installation.
- [ ] Open **DVWA Security**, choose the intended level (the project test cases expect **Low**), and submit the setting.
- [ ] Open the **SQL Injection** module and confirm the form loads before beginning the test cases.

## Run and record the tests

- [ ] Run TC-01 with the normal value listed in `sql_injection_notes.md`.
- [ ] Record what the page actually displayed. Do not infer an outcome from the test description.
- [ ] Run TC-02 with the stated read-only demonstration payload, only in the local DVWA SQL Injection module at the intended security level.
- [ ] Record exactly what appeared, such as the number of returned records, without copying expected output.
- [ ] Run TC-03 with the invalid value listed in the test notes.
- [ ] Record the actual response, including whether an error was displayed.
- [ ] Set each status only after running that test. Use **Inconclusive** if you cannot interpret the result; use **Not Run** if you did not run it.
- [ ] Save genuine screenshots using the suggested names in `screenshots/README.md`. Review and redact browser profile details, credentials, tokens, and unrelated private information before sharing.
- [ ] Stop Apache and MySQL in the XAMPP Control Panel when finished.

## Troubleshooting

| Symptom | Checks to try |
|---|---|
| Apache will not start | Check the XAMPP Control Panel log for the specific port conflict. Another local service may already use the configured port. Do not disable security controls blindly; identify the conflicting service or use XAMPP's documented local port configuration. |
| MySQL/MariaDB will not start | Check the XAMPP log for the cause and whether the configured port is already in use. Do not delete database files or change database contents as a first troubleshooting step. |
| `localhost` does not load | Confirm Apache is running and check the URL/port. Verify the DVWA folder is inside the actual XAMPP document root. A failed connection alone does not prove a firewall problem or an SQL injection vulnerability. |
| DVWA setup reports a database error | Compare the local DVWA configuration with the database service, database name, host, port, and dedicated lab account. Check that the DVWA database was initialized. Never paste passwords into a report or screenshot. |
| Login fails or a page redirects repeatedly | Confirm the local DVWA credentials and browser session/cookies. Follow the official DVWA instructions for the installed version. Do not substitute a real account password. |
| SQL Injection page errors or shows unexpected output | Confirm the module, selected security level, setup state, and exact input. Record the actual error and environment details; do not label it an SQL injection finding without evidence. |
| Browser reports a connection failure | Check whether the local service is running, the URL and port are correct, and a local proxy is interfering. A connection failure is not proof of an SQL injection vulnerability and does not by itself prove a firewall issue. |

For version-specific setup steps, consult the [official DVWA repository](https://github.com/digininja/DVWA) and use only its documented distribution and instructions.
