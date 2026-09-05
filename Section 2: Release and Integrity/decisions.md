# Release and Integrity Decisions

- SBOM: Syft + OCI/GitHub attestation.
- Signing: keyless Cosign; trust root is Sigstore, with verification pinned to the expected GitHub OIDC issuer/identity.
- OIDC `sub`: `repo:acme/accounts-api:environment:production`.
- This denies other repositories, branches, pull requests and environments from assuming the production role.
- ECR tags are immutable; production deploys by digest.
- Signature proves that the exact digest was signed by the expected CI identity.
- Signature does not prove source correctness, absence of vulnerabilities, safe runtime configuration, or post-deployment integrity.
- Traceability: T2, with T5 recurrence prevention.
