# Terraform State Issues and Solutions

## Common Problems

1. **Deleting the state file**: Can lead to loss of infrastructure tracking.
2. **Handling multiple environments**: Requires careful state management.
3. **Resource deleted via UI but not in Terraform**: Causes state mismatch.
4. **State locks**: Prevent concurrent modifications but can cause blocking.

## Solutions
- Always use remote state with locking.
- Regularly backup state files.
- Use `terraform refresh` to sync state with actual infrastructure.
- Implement proper CI/CD pipelines for environment management.