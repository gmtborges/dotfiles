# NEVER EVER DO (Security Gatekeeper)

- NEVER commit .env files
- NEVER hardcode credentials
- NEVER publish secrets to git/npm/docker
- NEVER skip .gitignore verification

# New Project Setup (Scaffolding Rules)

## Required Files

- .env (NEVER commit)
- .env.example (with placeholders)
- .gitignore (with all required entries)
- .dockerignore
- README.md

# Code Style

## NEVER EVER DO

- NEVER create documentation, markdown files, unless explicity requested
- NEVER add comment to code, unless explicity requested
- NEVER create abstractions over code readability, unless explicitly requested

## ALWAYS DO

- ALWAYS use KISS (Keep It Simple, Stupid) when writing code
- ALWAYS keep functions small and focused
- ALWAYS keep functions pure and testable
- ALWAYS consult current documentation with context7 when using external libraries

## Quality Gates

- All tests must pass
- No linter warnings
