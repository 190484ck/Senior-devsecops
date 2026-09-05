# Review and Remediate Findings

## Workload
1. Docker socket/hostPath — highest exploitability; pod compromise can reach host runtime.
2. hostNetwork — removes network namespace isolation.
3. UID 0 — increases compromise impact.
4. Wildcard RBAC including secrets — exposes credentials and object control.
5. `latest` — permits release drift.
6. `/var/log` hostPath — crosses host boundary and may expose sensitive logs.

## Terraform
1. Public RDS + 0.0.0.0/0:5432 — direct DB attack path.
2. Unencrypted storage — greater offline-data impact.
3. No backups/final snapshot — poor destructive-incident recovery.
4. Weak CloudTrail — reduced forensic visibility/integrity.

## IAM
Original `NotAction` effectively permits almost everything except two IAM delete actions. Replacement allows only named Secrets Manager/KMS/Kinesis operations on named resources.

Denied vs original: all unrelated AWS APIs/resources, including IAM administration and arbitrary account/data access.
