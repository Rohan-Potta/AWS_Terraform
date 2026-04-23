# State File Management

Used to compare the desired state (local) with the actual state (environment).

This is stored in a remote backend, not locally.

## Best Practices
1. Store the state file in a remote backend.
2. Cannot be updated/deleted manually.
3. State locking: Prevents multiple people from making changes simultaneously.
4. Isolation of state file from the environment.
5. Regular backups.

The remote state file is configured manually, not via Terraform.