# Section 1 — Threat Model

Assumptions: EKS `ap-south-1`; CloudFront/ALB is the edge; shared cluster; RDS PostgreSQL; message stream; AWS Secrets Manager/KMS; one public KYC provider.

```text
Internet -> [CloudFront/ALB] -> [accounts-api Pod / EKS]
                                  |-> RDS PostgreSQL
                                  |-> message stream
                                  |-> KYC provider
                                  |-> AWS APIs -> Secrets Manager/KMS

GitHub Actions -> GitHub OIDC -> AWS deploy role -> ECR/EKS

Shared EKS: accounts-api <-> other teams' workloads
```

| Rank | Entry point | Reach | Control |
|---|---|---|---|
| 1 | Exploit/auth failure at ALB | Pod -> customer data | **T1:** non-root, no host networking/hostPath, restricted RBAC, admission and runtime controls |
| 2 | Malicious/compromised image or mutable release | Pod/node/AWS APIs | **T2:** signed digest, immutable tags, SBOM, CI gates, least-privilege IAM |
| 3 | Leaked credential/over-broad identity | Secrets/KMS/streams/AWS | **T3:** Secrets Manager, full-history secret scan, scoped IAM |
| 4 | Public PostgreSQL exposure | Customer DB | **T4:** private RDS, encryption, restricted SG, backups |
| 5 | Malicious/compromised engineer change | Cluster/DB/audit controls | **T5:** policy-as-code, admission, gates, expiring waivers/break-glass |

**Risk accepted:** KYC endpoint details are unspecified; a fixed approved endpoint placeholder is used. Provider endpoint changes can cause availability impact until the allow-list is updated.

**Overrated threat:** arbitrary internet attacker taking over the entire AWS organisation is less likely than application/pod compromise followed by abuse of concrete permissions, so effort is concentrated on workload isolation, IAM, release integrity, DB exposure and admission.

All section controls map to T1–T5; scanner/admission/secret controls also provide structural recurrence prevention.
