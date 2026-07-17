---
name: claude-hunterkit-orchestrator
description: "Master orchestrator for claude-hunterKit — 170 offensive security skills. Recon-first pipeline: deep recon → decision matrix → targeted exploit. Routes hunting tasks to the correct skill based on target type."
---

# claude-hunterKit Orchestrator

Recon-first conditional agent launch pipeline for 170 offensive security skills.

## Pipeline

```
PHASE 0: Categorize target → route to domain orchestrator
PHASE 1a: Network/Stack recon (recon-01,02,03)
PHASE 1b: Surface mapping (recon-04,05,06)
PHASE 1c: Defense analysis (recon-07,08,09,10,11)
PHASE 2: Consult recon-decision-matrix.yaml → match signals → select agents
PHASE 3: Targeted exploit on matched skills only
PHASE 4: Chain & escalate via matrix escalation paths
PHASE 5: Report findings
```

**Cardinal rule:** Complete ALL of Phase 1 before launching ANY vuln agent.

## Domain Routing

| Target Type | Directory | Launch Strategy |
|-------------|-----------|----------------|
| Web app | skills/web/_orchestrator/ | Phase 1 recon → decision matrix → conditional launch |
| API | skills/api/_orchestrator/ | Phase 1 recon → signal-to-agent mapping → conditional launch |
| AI/LLM | skills/ai/ | Start with ai-02-llm-enum-recon for endpoint discovery |
| Network/Infra | skills/network/ | Start with net-01-cloud or net-04-k8s |
| Cloud | skills/cloud/ | Use cloud-02-cloud-advanced for full depth |
| Auth | skills/auth/_orchestrator/ | Phase 1 auth recon → launch only matched scheme |
| Recon | skills/recon/ | 11 recon skills — run all before deciding |
| Bug Bounty | bugbounty/bugbounty-master/ | Full workflow from recon to report |

## Decision Matrix

`skills/_hunter/recon-decision-matrix.yaml` contains 40+ signal rules mapping recon findings to specific vuln agents. Launch ONLY agents whose signals match.

## Quick Reference

```bash
# List all skills in a domain
ls skills/web/
ls skills/api/

# Read recon decision matrix
cat skills/_hunter/recon-decision-matrix.yaml

# Search for a vuln class
grep -rl "ssrf" skills/*/SKILL.md
```
