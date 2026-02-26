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

# Code Conventions

## NEVER EVER DO

- NEVER create documentation, markdown files
- NEVER add comment to code
- NEVER create abstractions over code readability

## ALWAYS DO

- ALWAYS use KISS (Keep It Simple, Stupid) when writing code
- ALWAYS keep functions small
- ALWAYS keep functions pure and testable
- ALWAYS consult current documentation with context7 when using external libraries

## Commands

Always set the AWS_PROFILE={org}-{env} before run terraform or cdk commands.

On CDK projects use package managers to run cdk commands. For example:

```sh
npm run cdk -- ...
uv run cdk ...
poetry run cdk ...
```

## Naming conventions

Every resource name should be
${prefix}-${environment}-${resource-abbreviation}. In case of workloads add
${app-name} after the environment.
Ignore resource-abbreviation for s3 buckets.

Also add tag Name.

- Apply to every new resource and module (e.g. gha for GitHub Actions, -pol for policies, -role for IAM roles,
  -svc for ECS Services).”
- One example: Role: {prefix}-{env}-gha-role; policy: {prefix}-{env}-gha-ecs-deploy-pol; service:
  {prefix}-{env}-hello-world-svc

## Quality Gates

- All tests must pass
- No linter warnings
