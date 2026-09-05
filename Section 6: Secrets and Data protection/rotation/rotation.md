# Rotation

Source of truth: AWS Secrets Manager. External Secrets Operator authenticates through EKS Pod Identity/IRSA and materialises runtime secrets. No plaintext credentials are committed.

Normal rotation:
- DB credential: every 30 days.
- KYC credential: every 30 days.

Emergency: generate replacement -> update Secrets Manager -> refresh/restart all replicas -> validate -> revoke compromised credential.

**Target:** every accounts-api credential rotated within 15 minutes of the decision to rotate. If that cannot be achieved, isolate service network/AWS access rather than leave a known-compromised credential active.
