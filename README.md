# ansible-playbooks

My ansible playbooks

## Playbooks

### Apache Zeppelin

[Apache Zeppelin](https://zeppelin.apache.org/) is a web-based dashboard for data analytics.
This playbook constructs a stand-alone Zeppelin server, i.e., not clustered.

```
ansible-playbook -i inventory zeppelin-standalone.yml
```

### JupyterHub

[JupyterHub](https://jupyterhub.readthedocs.io/en/latest/) is a multi-user
version of [Jupyter](https://jupyter-notebook.readthedocs.io/en/latest/)
(iPython notebook), a web-based document tool for data analytics.

```
ansible-playbook -i inventory jupyterhub.yml
```

## Roles

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
