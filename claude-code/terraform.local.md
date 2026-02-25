# Commands

Always set the AWS_PROFILE={org}-{env} before run terraform commands.

# Naming conventions

Every resource name should be
${prefix}-${environment}-${resource-abbreviation}. In case of workloads add
${app-name} after the environment.

Also add tag Name.

- Apply to every new resource and module (e.g. gha for GitHub Actions, -pol for policies, -role for IAM roles,
  -svc for ECS Services).”
- One example: Role: {prefix}-{env}-gha-role; policy: {prefix}-{env}-gha-ecs-deploy-pol.”
