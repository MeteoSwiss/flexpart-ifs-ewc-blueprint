# FLEXPART-IFS EWC Blueprint

Deploy FLEXPART-IFS on the European Weather Cloud (EWC).

```text
ECMWF MARS → flexprep → FLEXPART-IFS → Pyflexplot → PDF plots
```

## Deploy with EWCCLI

Use an **ECMWF-side** EWCCLI profile. For custom-catalog deployment, use
**EWCCLI 0.7.1 or newer**:

```bash
ewc login
ewc hub \
  --path-to-catalog ./catalog/custom_catalog.yml \
  deploy flexpart-ifs \
  --flavour-name 8cpu-16gbmem-80gbdisk
```

The workflow has been tested with 8 vCPU, 16 GiB RAM and 80 GB storage.
Smaller flavours may not provide enough resources for FLEXPART-IFS runs.

The blueprint metadata defaults to **Ubuntu 24.04** and requests an external IP.
EWCCLI resolves the current matching image for the selected EWC region, uses the
appropriate Ubuntu SSH account, and passes the external IP to Ansible.

If the native `mars` client is missing, the blueprint applies the official
**ECMWF Data Flavour 2.0.2** before installing FLEXPART-IFS. The automatic Data
Flavour bootstrap is intentionally Ubuntu-based, matching the upstream item.
The local system and Docker roles remain usable on Rocky/RHEL-family hosts when
a native MARS client is already available.

Organisation-specific SSH routing is deliberately not part of the blueprint. If
your environment requires a SOCKS proxy, VPN or bastion, configure it locally in
SSH/Ansible.

To recreate an existing test VM using the catalogue defaults:

```bash
ewc hub \
  --path-to-catalog ./catalog/custom_catalog.yml \
  deploy flexpart-ifs \
  --force
```

## Configure MARS

On the VM, add your personal ECMWF credentials to the workflow operator's:

```text
~/.ecmwfapirc
```

Your ECMWF account must have access to the required IFS data.

## Run

```bash
flexpart-workflow --latest --step 24 --location BEZ
```

For a reproducible forecast cycle:

```bash
flexpart-workflow --date 20260810 --time 00 --step 24 --location BEZ
```

`--location` is a predefined FLEXPART release site.

## Results

PDF plots are written to:

```text
/var/lib/flexpart-ifs/plots
```

## Alternative: Ansible

The same playbook can configure an existing VM:

```bash
cp inventory.example.yml inventory.yml
ansible-galaxy install -r requirements.yml
ansible-playbook -i inventory.yml deploy.yml
```

Ubuntu 24.04 is recommended. On a non-Ubuntu VM, provide the native MARS client
before running the playbook if the upstream ECMWF Data Flavour cannot be used.

## License

The deployment code and documentation are licensed under the Apache License
2.0. Deployed components retain their own licences; see
[THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).
