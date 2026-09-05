#!/usr/bin/env python3
import datetime as dt, sys, yaml
from pathlib import Path
now = dt.datetime.now(dt.timezone.utc)
errors = []
for p in Path("section-3/pipeline-gates/waivers").glob("*.yaml"):
    if p.name.startswith("example-"): continue
    x = yaml.safe_load(p.read_text())
    if not x.get("id") or not x.get("expires_at") or len(x.get("approvers", [])) < 2:
        errors.append(f"{p}: missing required waiver fields"); continue
    expiry = dt.datetime.fromisoformat(x["expires_at"].replace("Z", "+00:00"))
    if expiry <= now: errors.append(f"{p}: waiver expired")
if errors: print("\n".join(errors)); sys.exit(1)
print("waiver expiry check: PASS")
