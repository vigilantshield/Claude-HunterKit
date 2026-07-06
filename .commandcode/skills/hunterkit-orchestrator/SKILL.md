---
name: claude-hunterkit-orchestrator
description: "Master orchestrator for claude-hunterKit — 170 offensive security skills. Routes hunting tasks to the correct skill based on target type. Use when starting a security assessment, bug bounty session, or pentest."
---

# claude-hunterKit Orchestrator

You have access to the claude-hunterKit repository with 170 offensive security skills.

## How to use

1. **Identify the target type** — web app, API, AI/LLM, network, cloud, or auth
2. **Open the matching skill** from the repository's skills/ directory
3. **Follow the skill's methodology** — each has Hacker Mindset, Detection, Payloads, Bypass, Chaining, OOB
4. **Report findings** using human-voice reporting

## Domain Routing

| Target Type | Directory | How to Start |
|-------------|-----------|-------------|
| Web app | skills/web/ | Pick web-XX matching the vuln class. Follow Detection → Payloads → Bypass → Chain |
| API | skills/api/ | Start with api-01-spec-ingestion for endpoint discovery |
| AI/LLM | skills/ai/ | Start with ai-02-llm-enum-recon for endpoint discovery |
| Network/Infra | skills/network/ | Start with net-01-cloud for cloud or net-04-k8s for Kubernetes |
| Cloud | skills/cloud/ | Use cloud-02-cloud-advanced for full AWS/Azure/GCP depth |
| Auth | skills/auth/ | Use auth-01-jwt or auth-02-oauth-oidc |
| Recon | skills/recon/ | Start with recon-01-osint for target discovery |
| Bug Bounty | bugbounty/bugbounty-master/ | Full workflow from recon to report |

## Quick Reference

```bash
# List all skills in a domain
ls skills/web/
ls skills/api/

# Search for a vuln class
grep -rl "ssrf" skills/*/SKILL.md
```
