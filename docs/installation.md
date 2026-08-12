# Installation

## EWCCLI deployment

EWCCLI 0.7.1 or newer is recommended for custom-catalog deployment. The item
metadata defaults to Ubuntu 24.04 and requests an external IP, so EWCCLI can use
the externally reachable address for the Ansible phase.

```bash
ewc hub \
  --path-to-catalog ./catalog/custom_catalog.yml \
  deploy flexpart-ifs
```

To recreate an existing VM using the item defaults:

```bash
ewc hub \
  --path-to-catalog ./catalog/custom_catalog.yml \
  deploy flexpart-ifs \
  --force
```

The caller remains responsible for local routing to the external IP. For example,
a corporate SOCKS proxy or bastion belongs in the caller's SSH/Ansible
configuration, not in the Community Hub blueprint.

## Existing-VM installation

1. Create a supported EWC VM. Ubuntu 24.04 is recommended.
2. Ensure SSH access works.
3. Ensure a native MARS client is already available on non-Ubuntu hosts, or use Ubuntu so the blueprint can bootstrap ECMWF Data Flavour 2.0.2.
4. Copy `inventory.example.yml` to `inventory.yml` and edit it.
5. Install Ansible requirements:

   ```bash
   ansible-galaxy install -r requirements.yml
   ```

6. Run the playbook:

   ```bash
   ansible-playbook -i inventory.yml deploy.yml
   ```

7. Configure the user's ECMWF MARS credentials as described in the README.
8. Validate the installation with the installed workflow tooling.
