# SQL Injection Remediation

## Why unsafe query construction is vulnerable

SQL injection occurs when an application combines user input and SQL code as one string. If input is inserted directly into the query, characters in that input can change the query's meaning. The database may then return data or perform an action that the application did not intend.

Escaping input manually is difficult to get right across database engines and character encodings. Validation is useful, but it is not a replacement for separating SQL code from data.

## Prepared statements and parameterized queries

A prepared statement defines the SQL structure separately from its values. The database driver sends parameter values as data, so a value cannot change the query's SQL structure. Use the parameter style supported by your database driver; do not build a query by concatenating user-controlled values.

The following PHP PDO example is for defensive application development. It reads a single numeric identifier and uses a bound parameter. It is not a replacement for DVWA's intentionally vulnerable code, and it does not change DVWA.

```php
<?php
$databaseUser = getenv('DVWA_DB_USER');
$databasePassword = getenv('DVWA_DB_PASSWORD');

$pdo = new PDO(
    'mysql:host=127.0.0.1;dbname=dvwa;charset=utf8mb4',
    $databaseUser,
    $databasePassword,
    [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]
);

$userId = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
if ($userId === false || $userId === null || $userId < 1) {
    http_response_code(400);
    exit('Invalid user ID.');
}

$statement = $pdo->prepare(
    'SELECT first_name, last_name FROM users WHERE user_id = :user_id'
);
$statement->bindValue(':user_id', $userId, PDO::PARAM_INT);
$statement->execute();
$user = $statement->fetch(PDO::FETCH_ASSOC);
```

Store credentials outside source control, such as in a protected environment configuration. Do not hard-code them in application files or commit them to a public repository. SQL parameters represent values, not table names, column names, or sort directions. If those SQL parts must vary, choose them from a strict allowlist in code.

## Additional defenses

- **Input validation:** Validate format, type, length, and allowed range at the application boundary. Reject values that do not match the expected format. Continue using prepared statements even for validated values.
- **Least-privilege database accounts:** Give the application account only the permissions it needs, scoped to its own database and operations. Do not connect as a database administrator. Keep lab credentials separate from real credentials.
- **Safe error handling:** Show users a generic error message. Keep detailed database errors in access-controlled logs, and avoid logging passwords, session tokens, or submitted sensitive values. Do not expose stack traces or SQL text to visitors.
- **Secure configuration:** Keep software updated, disable debug output in production, protect configuration files, use secure secret storage, and restrict database/network access. An intentionally vulnerable DVWA instance must stay local and must not be exposed to the internet or an untrusted network.
- **Review and testing:** Use code review, security testing, and regression tests to verify that all database access paths use parameters. Do not treat one successful test as proof that an application is secure.

## Reference

- OWASP, [SQL Injection Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html)
