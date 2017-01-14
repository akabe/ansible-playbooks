# ansible-playbooks

My ansible playbooks

## Playbooks

### Apache Zeppelin

[Apache Zeppelin](https://zeppelin.apache.org/) is a web-based dashboard for data analytics.

```
ansible-playbook -i inventory zeppelin.yml
```

### JupyterHub

[JupyterHub](https://jupyterhub.readthedocs.io/en/latest/) is a multi-user
version of [Jupyter](https://jupyter-notebook.readthedocs.io/en/latest/)
(iPython notebook), a web-based document tool for data analytics.

```
ansible-playbook -i inventory jupyterhub.yml
```

## Roles

- `roles/users`
  - Add users
  - Authorize SSH keys
  - You **must** override variable `users`!
- `roles/sshd`
  - Configure SSH daemon
  - Restart SSH daemon
- `roles/linux-tuning`
  - Upgrade yum packages
  - Stop non-essential services (`sendmail`, `crond`, etc.)
  - Disable extra TTYs
  - Reboot a machine
- `roles/swapfile`
  - Allocate a swap file and mount it as swap space (4 GiB by default)
- `roles/zeppelin`
  - Install [Zeppelin](https://zeppelin.apache.org/) (without interpreters, but they can be net-installed)
  - Add the JDBC MySQL driver
- `roles/python`
  - Build and install python
  - You can specify `python_pip3_packages` to install pip packages
- `roles/jupyterhub`
  - Install [JupyterHub](https://jupyterhub.readthedocs.io/en/latest/)
