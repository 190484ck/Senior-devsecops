# Runtime Alert and Runbook

**Payload:** shell command, user/UID, pod, namespace, container, image, parent process and source IP.

**Routing:** Falco -> central SIEM -> `#accounts-api-security` -> PagerDuty `accounts-api-platform`.

**Owner:** platform on-call.

**First three steps:**
1. Isolate the pod/workload and stop an active rollout.
2. Preserve pod metadata, image digest, deployment SHA, Kubernetes audit and Falco evidence.
3. Review the pod IAM role's CloudTrail activity and recent requests; rotate credentials if compromise is plausible.

**#falco-rul.yaml**

- rule: accounts-api unexpected shell
  desc: Detect shell execution inside accounts-api production pods.
  condition: >
    spawned_process and container and
    k8s.ns.name=accounts and k8s.pod.label.app=accounts-api and
    proc.name in (sh,bash,zsh,dash,ash)
  output: >
    accounts-api shell execution user=%user.name uid=%user.uid
    pod=%k8s.pod.name namespace=%k8s.ns.name container=%container.name
    image=%container.image.repository proc=%proc.cmdline parent=%proc.pname source_ip=%fd.sip
  priority: WARNING
  tags: [accounts-api, shell-exec]
