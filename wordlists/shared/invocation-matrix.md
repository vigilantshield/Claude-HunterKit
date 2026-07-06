# Invocation Matrix

| Module type | Start with | Then | Escalate to |
|---|---|---|---|
| Header/config bugs | `confirm/` | `parameters/` | `payloads/` only after a clear signal |
| Input-driven injection | `parameters/` | low-risk `payloads/` | encoded/chained `payloads/` |
| Browser-only bugs | `confirm/` | `parameters/` | Playwright/browser proof |
| Inventory/discovery bugs | `confirm/` | `parameters/` | passive `payloads/` if needed |
| Supply-chain and dependency checks | `confirm/` | `parameters/` | targeted response scanning and trust-header probes |

## Timing / state warnings

- Do not use time-based payloads before capturing a baseline.
- Do not use state-changing payloads before deciding whether proof requires auth.
- Do not use browser tooling when raw HTTP already proves impact.
