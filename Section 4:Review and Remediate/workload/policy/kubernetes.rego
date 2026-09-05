package main

deny contains "T1: hostNetwork must be false" if input.kind == "Deployment" and input.spec.template.spec.hostNetwork == true
deny contains "T1: container must run non-root" if { input.kind == "Deployment"; some c in input.spec.template.spec.containers; not c.securityContext.runAsNonRoot }
deny contains "T1: UID 0 is forbidden" if { input.kind == "Deployment"; some c in input.spec.template.spec.containers; c.securityContext.runAsUser == 0 }
deny contains "T1: hostPath volumes are forbidden" if { input.kind == "Deployment"; some v in input.spec.template.spec.volumes; v.hostPath }
deny contains "T1/T2: Docker socket mount is forbidden" if { input.kind == "Deployment"; some v in input.spec.template.spec.volumes; v.hostPath.path == "/var/run/docker.sock" }
deny contains "T2: mutable latest image tag is forbidden" if { input.kind == "Deployment"; some c in input.spec.template.spec.containers; endswith(c.image, ":latest") }
deny contains "T5: wildcard RBAC verbs are forbidden" if { input.kind == "Role"; some r in input.rules; r.verbs[_] == "*" }
deny contains "T3: Role must not read secrets" if { input.kind == "Role"; some r in input.rules; r.resources[_] == "secrets" }
