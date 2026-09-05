# Log Redaction

Redact at application logging before serialization: names, email, phone, IBAN, balances, card data beyond permitted last four, authorization headers, cookies, tokens, API keys, passwords/secrets and sensitive KYC bodies.

Apply a second safety pass in the central logging pipeline. ALB/ingress logging excludes request bodies and authorization headers.

Residual leakage can include timing, endpoint, status, payload size, correlation IDs and free-form exception text. Regex masking is a safety net, not the primary control.
