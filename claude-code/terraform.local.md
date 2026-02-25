# Commands

Always set the AWS_PROFILE={org}-{env} before run terraform commands.

# Naming conventions

Every resource name should be
${prefix}-${environment}-${resource-abbreviation}. In case of workloads add
${app-name} after the environment.

Also add tag Name.
