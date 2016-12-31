# ansible-playbooks

My ansible playbooks

## Roles

- `roles/linux-tuning`
  - Upgrade yum packages
  - Stop non-essential services (`sendmail`, `crond`, etc.)
  - Disable extra TTYs
  - Reboot a machine
- `roles/swapfile`
  - Allocate a swap file and mount it as swap space (4 GiB by default)
