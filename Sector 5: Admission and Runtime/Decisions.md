# Admission, Runtime and Egress Decisions

Kyverno is ENFORCE day one for namespace `accounts`. Wider rollout requires 14 days of audit telemetry, >95% violations remediated/waived and platform sign-off.

Egress permits DNS, internal PostgreSQL and the approved KYC HTTPS endpoint. Kubernetes NetworkPolicy alone is not a robust FQDN control and cannot prevent exfiltration through an already-approved KYC destination; production should use an egress gateway/proxy with FQDN/certificate-aware controls.
