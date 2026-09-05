# Break-Glass

Trigger only for a production-down/customer-impacting incident where waiting for normal gates prolongs outage.

1. Open incident; record incident ID, operator, reason and time.
2. Assume separately protected emergency AWS role.
3. Make the smallest recovery change, record it, then restore normal controls.

Audit trail: AWS STS/API activity in CloudTrail, EKS audit events, GitHub workflow actor/SHA/environment, and incident ticket linked to emergency session/change set.

Within 24 hours review, remove temporary access/waiver, restore normal gates and create permanent remediation.



# Pipeline Gates

| Area | Tool | Blocking line | Rationale |
|---|---|---|---|
| SCA | Trivy | High/Critical | Simple consolidated dependency/container coverage |
| SAST | Semgrep | High/Critical | Fast code-aware checks |
| Secrets | Gitleaks | Any confirmed secret | Credentials are immediately exploitable |
| IaC | Checkov + Conftest | High/Critical / explicit policy | Provider coverage plus deterministic controls |

Full Git history is scanned because checkout uses `fetch-depth: 0` and Gitleaks scans `--all`.

False positives expected: roughly 1–5 tuning candidates per ordinary PR after baseline. Tune narrow paths/rules first; do not lower the severity line.
