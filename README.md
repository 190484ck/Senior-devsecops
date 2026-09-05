**1.---------- Readme -------**


# accounts-api Security Submission

Based on the supplied reference scenario. The reference explicitly permits local authoring/validation without deploying to real AWS and lists the open-source security tooling used here. 

## Reviewer commands

```bash
conftest test --policy section-4/kubernetes/policy/kubernetes.rego section-4/kubernetes/tests/test.yaml

conftest test --policy section-4/terraform/policy/terraform.rego section-4/terraform/tests/teststf.yaml

kyverno test section-5/admission/kyverno-tests
terraform -chdir=section-4/terraform/fixed init -backend=false
terraform -chdir=section-4/terraform/fixed validate
gitleaks git . --redact --log-opts="--all"
```

Bad fixtures are expected to fail; good fixtures are expected to pass.

### Gates
- Critical/High: blocking.
- Medium: reported, non-blocking.
- Low/Unknown: informational.
- Confirmed secrets: always blocking.
- Scanner/tool failure: blocking.

### Waivers
Waivers are in `section-3/waivers/`, require two approvers, justification, compensating control and hard expiry. Expired waivers fail CI.

### Release integrity
SBOM is attached as an OCI attestation. Cosign signs the image digest keylessly and CI verifies the expected GitHub OIDC identity. ECR tags are immutable and production deploys by digest.

The signature proves provenance/integrity of the signed digest. It does not prove vulnerability-free software, correct business logic, safe runtime configuration, or compromise-free operation after deployment.



**2.---------- Deliverables -------**

# Deliverables Index

- README.md
- section-1-threat-model/threat-model.md
- section-2-release-integrity/github-actions.yml
- section-2-release-integrity/iam-oidc-trust-policy.json
- section-2-release-integrity/decisions.md
- section-3-pipeline-gates/scan-gates.md
- section-3-pipeline-gates/waivers/waiver.yaml
- section-3-pipeline-gates/waivers/check_waivers.py
- section-3-pipeline-gates/break-glass.md
- section-4-review-remediate/workload/fixed-accounts-api.yaml
- section-4-review-remediate/workload/policy/kubernetes.rego
- section-4-review-remediate/workload/tests/test.yaml
- section-4-review-remediate/terraform/fixed/rds-cloudtrail.tf
- section-4-review-remediate/terraform/policy/terraform.rego
- section-4-review-remediate/terraform/tests/testtf.yaml
- section-4-review-remediate/iam/accounts-api-pod-policy.json
- section-4-review-remediate/review-findings.md
- sector-5-admission-runtime/admission/kyverno-tests/kyverno-policy.yaml
- sector-5-admission-runtime/admission/kyverno-tests/kyverno-test.yaml
- sector-5-admission-runtime/admission/kyverno-tests/bad-deployment.yaml
- sector-5-admission-runtime/runtime/falco-rule.yaml
- sector-5-admission-runtime/runtime/runbook.md
- sector-5-admission-runtime/egress/accounts-api-egress.yaml
- sector-5-admission-runtime/decisions.md
- section-6-secrets-data/secrets/external-secret.yaml
- section-6-secrets-data/rotation/rotation.md
- section-6-secrets-data/log-redaction/log-redaction.md
- section-6-secrets-data/encryption.md
