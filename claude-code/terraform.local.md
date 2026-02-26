# Commands

Always set the AWS_PROFILE={org}-{env} before run terraform or cdk commands.

On CDK projects use package managers to run cdk commands. For example:

```sh
npm run cdk -- ...
uv run cdk ...
poetry run cdk ...
```

# Naming conventions

Every resource name should be
${prefix}-${environment}-${resource-abbreviation}. In case of workloads add
${app-name} after the environment.
Ignore resource-abbreviation for s3 buckets.

Also add tag Name.

- Apply to every new resource and module (e.g. gha for GitHub Actions, -pol for policies, -role for IAM roles,
  -svc for ECS Services).”
- One example: Role: {prefix}-{env}-gha-role; policy: {prefix}-{env}-gha-ecs-deploy-pol; service:
  {prefix}-{env}-hello-world-svc
