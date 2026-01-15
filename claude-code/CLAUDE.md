## NEVER EVER DO (Security Gatekeeper)

- NEVER commit .env files
- NEVER hardcode credentials
- NEVER publish secrets to git/npm/docker
- NEVER skip .gitignore verification

## New Project Setup (Scaffolding Rules)

### Required Files

- .env (NEVER commit)
- .env.example (with placeholders)
- .gitignore (with all required entries)
- .dockerignore
- README.md
- CLAUDE.md

### Quality Gates

- No file > 300 lines
- All tests must pass
- No linter warnings
- CI/CD workflow required

## Required MCP Servers

- context7 (live documentation)
- playwright (browser testing)
