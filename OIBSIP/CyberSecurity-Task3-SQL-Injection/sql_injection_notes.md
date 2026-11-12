# SQL Injection Test Notes — DVWA Local Lab

> **Project:** Task 3 — SQL Injection Testing  
> **Application:** DVWA (local, http://localhost/dvwa/)  
> **Security Level:** Low (configured in DVWA Security settings)  
> **Tester:** _(Enter your name)_  
> **Date:** _(Enter the date you performed testing)_

---

## Important Reminder

The **Expected Behavior** column describes what would typically happen based on how the DVWA SQL Injection module works. It is provided for reference only.

The **Actual Observation** column must be filled in by you after you have personally performed each test. It is intentionally blank below. Do not copy expected results into this column.

All statuses should remain **Not Run** until you have executed the test yourself.

---

## Test Cases

---

### TC-01 — Normal Valid Input

| Field | Details |
|-------|---------|
| **Test Case ID** | TC-01 |
| **Test Objective** | Verify that the DVWA SQL Injection form responds correctly to a valid, expected user input and returns the appropriate user record. |
| **Security Level** | Low |
| **Module** | SQL Injection (http://localhost/dvwa/vulnerabilities/sqli/) |
| **Input Used** | `1` |
| **Expected Behavior** | The application queries the database for user ID 1 and displays the corresponding first name and surname (e.g., `First name: admin`, `Surname: admin`). No error is shown. |
| **Actual Observation** | |
| **Status** | Not Run |
| **Screenshot Filename** | `tc01_normal_input.png` |

**Explanation of This Test:**

This is a baseline test. A normal input (the number `1`) is submitted to confirm that the application is working correctly before any injection is attempted. If this test does not return a user record, check whether DVWA is properly set up and the database has been initialized via `setup.php`.

A result of "First name: admin / Surname: admin" (or similar) would indicate the application is functioning normally. The exact output depends on your local DVWA database, so do not assume a specific name without running the test.

---

### TC-02 — SQL Injection Demonstration (Harmless Payload in DVWA)

| Field | Details |
|-------|---------|
| **Test Case ID** | TC-02 |
| **Test Objective** | Demonstrate that the DVWA SQL Injection module at Low security is vulnerable to a simple SQL injection payload that manipulates the WHERE clause of the underlying query. |
| **Security Level** | Low |
| **Module** | SQL Injection (http://localhost/dvwa/vulnerabilities/sqli/) |
| **Input Used** | `1' OR '1'='1` |
| **Expected Behavior** | Because the application at Low security does not sanitize input, the injected payload causes the SQL query's WHERE clause to evaluate as always-true. The application is expected to return multiple user records from the database instead of just one. |
| **Actual Observation** | |
| **Status** | Not Run |
| **Screenshot Filename** | `tc02_sql_injection_payload.png` |

**Explanation of This Test:**

At Low security, the DVWA source code constructs the SQL query by directly appending user input:

```php
// Example of vulnerable code (from DVWA Low security source)
$query  = "SELECT first_name, last_name FROM users WHERE user_id = '$id';";
```

When the input `1' OR '1'='1` is submitted, the query becomes:

```sql
SELECT first_name, last_name FROM users WHERE user_id = '1' OR '1'='1';
```

The condition `'1'='1'` is always true, so the database returns all rows in the users table. This is a classic SQL injection behaviour.

**Keep this read-only demonstration limited to your local DVWA lab:**
- Use only the synthetic records created by DVWA's own setup. Do not add real or personal data.
- This payload is intended to read records; it does not modify or delete them. Do not add destructive SQL or try to access unrelated databases.
- Run it only on your own computer, not on an external system.

Record the exact number of records returned and any user details displayed. Do not record invented output.

---

### TC-03 — Invalid / Non-Existent Input

| Field | Details |
|-------|---------|
| **Test Case ID** | TC-03 |
| **Test Objective** | Verify how the application handles an input that does not correspond to any existing user ID in the database. |
| **Security Level** | Low |
| **Module** | SQL Injection (http://localhost/dvwa/vulnerabilities/sqli/) |
| **Input Used** | `999` |
| **Expected Behavior** | The application should query for user ID 999. Since no such user exists in the default DVWA database, the result set should be empty and no user record should be displayed. The application may show a blank result or a "User ID is MISSING from the database." message. |
| **Actual Observation** | |
| **Status** | Not Run |
| **Screenshot Filename** | `tc03_invalid_input.png` |

**Explanation of This Test:**

This test confirms that the application handles empty result sets gracefully. A blank result or "user missing" message for an invalid ID is the expected behavior. If the application returns an unhandled database error message, this could also indicate verbose error handling — a separate security concern worth noting.

---

## Status Key

| Status | Meaning |
|--------|---------|
| **Not Run** | The test has not been executed yet |
| **Passed** | The actual observation matched the expected behavior for this test; this does not mean DVWA is secure |
| **Failed** | The test ran, but the actual observation did not match the expected behavior |
| **Inconclusive** | The test was run but the result could not be clearly interpreted |

---

## Summary Table

Fill this in after completing all tests.

| Test ID | Description | Status | Screenshot |
|---------|------------|--------|-----------|
| TC-01 | Normal valid input | Not Run | tc01_normal_input.png |
| TC-02 | SQL injection payload | Not Run | tc02_sql_injection_payload.png |
| TC-03 | Invalid / non-existent input | Not Run | tc03_invalid_input.png |

---

## Additional Notes

_(Use this space to record any unexpected behaviors, error messages, or observations that do not fit neatly into the test cases above.)_

---

*Expected behavior is only a prediction. Record actual observations and change a status only after personally running that test in the local DVWA lab.*
