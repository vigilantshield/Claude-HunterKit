# Wordlist Index

Fast entry points into the vendored payload sets.

## AI and LLM

- Prompt injection: `../ai/ai-03-prompt-injection/`
- System prompt leakage: `../ai/ai-04-system-prompt-leakage/`
- Jailbreaking: `../ai/ai-05-jailbreaking/`
- MCP and tool-scope abuse: `../ai/ai-16-mcp-security/`
- Agentic attacks and excessive agency: `../ai/ai-19-agentic-attacks/`, `../ai/ai-08-excessive-agency/`
- LLM infra and model endpoint discovery: `../ai/ai-25-llm-infra-security/`, `../ai/ai-43-model-api-enumeration/`
- Secret leakage and output sink abuse: `../ai/ai-47-agent-secret-leakage/`, `../ai/ai-46-output-sink-injection/`

## MCP and Devtools

- MCP exposure and tool scope: `../mcp-devtools/ai-16-mcp-security/`
- Agent overreach and tool misuse: `../mcp-devtools/ai-19-agentic-attacks/`, `../mcp-devtools/ai-08-excessive-agency/`
- LLM infra and model/tool endpoints: `../mcp-devtools/ai-25-llm-infra-security/`, `../mcp-devtools/ai-43-model-api-enumeration/`
- Tool identity and auth confusion: `../mcp-devtools/ai-26-llm-auth-ac/`, `../mcp-devtools/ai-45-agent-identity-scope/`
- Output sink and secret leakage: `../mcp-devtools/ai-46-output-sink-injection/`, `../mcp-devtools/ai-47-agent-secret-leakage/`
- API-side tool abuse: `../mcp-devtools/api-24-llm-api-security/`
- Infra-side AI/MCP paths: `../mcp-devtools/net-56-ai-infra/`

## Discovery

- Tech fingerprinting: `../recon/recon-16-tech-fingerprint/`
- JavaScript analysis: `../recon/recon-17-js-analysis/`
- OpenAPI discovery: `../recon/recon-32-openapi-active-enum/`
- API docs and hidden paths: `../api/api-26-api-doc-leakage/`
- Spec ingestion paths: `../api/api-01-spec-ingestion/`

## Auth

- Login and auth abuse: `../auth/web-05-auth/`, `../auth/api-05-auth-attack/`
- JWT and JWE: `../auth/web-66-jwt-attacks/`, `../auth/web-67-jwe-attacks/`, `../auth/api-28-jwt-attacks/`
- OAuth, OIDC, SAML: `../auth/web-16-oauth-oidc/`, `../auth/web-68-oauth-saml-advanced/`, `../auth/api-14-oauth-saml/`
- Session, 2FA, rate limits: `../auth/web-32-2fa-bypass/`, `../auth/web-34-session-management/`, `../auth/web-35-rate-limit-bypass/`

## Injection and Access Control

- SQLi: `../web/web-03-sqli/`
- NoSQL: `../web/web-45-nosql-injection/`, `../api/api-12-nosql-db-injection/`
- SSRF: `../web/web-07-ssrf/`, `../api/api-13-webhook-async/`
- GraphQL: `../web/web-12-graphql/`, `../web/web-47-graphql-injection/`
- IDOR/BOLA: `../web/web-36-guid-idor/`, `../api/api-04-bola/`, `../api/api-27-advanced-bola/`
- Mass assignment: `../web/web-46-mass-assignment/`, `../api/api-06-mass-assignment/`
- CSP analysis: `../web/web-18-csp-analysis/`
- Path traversal: `../web/web-49-path-traversal/`
- Clickjacking: `../web/web-30-clickjacking/`
- SRI / third-party integrity: `../web/web-63-sri-check/`, `../api/api-21-supply-chain/`

## Protocol and Path Abuse

- HTTP smuggling/desync: `../web/web-39-http-smuggling/`, `../network/net-44-http2-desync/`
- Host header and CRLF: `../web/web-28-host-header/`, `../web/web-29-crlf/`
- Traversal and LFI-style path work: `../web/web-08-file-upload-lfi/`, `../web/web-49-path-traversal/`
- SOAP/XML-RPC: `../api/api-29-soap-xmlrpc/`, `../api/api-36-xmlrpc-advanced/`

## Infra Crossover

- Cloud IAM: `../network/net-26-cloud-iam/`
- Container/K8s: `../network/net-25-container-k8s/`
- Service mesh: `../network/net-46-service-mesh/`
- Serverless: `../network/net-45-serverless-faas/`
- Secrets/config exposure: `../network/net-50-secrets-config/`

## Auth Profiling

- Auth scheme discovery: `../api/api-03-auth-profiling/`
