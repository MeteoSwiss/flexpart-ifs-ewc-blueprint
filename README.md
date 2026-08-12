# FLEXPART-IFS EWC Blueprint

Deploy FLEXPART-IFS on the European Weather Cloud (EWC).

```text
ECMWF MARS → flexprep → FLEXPART-IFS → Pyflexplot → PDF plots
```

## Deploy with EWCCLI

Use an **ECMWF-side** EWCCLI profile:

```bash
ewc login
ewc hub deploy flexpart-ifs
```

EWCCLI creates the VM and runs this blueprint. If the native `mars` client is
missing, the blueprint first applies the official **ECMWF Data Flavour 2.0.2**.
The Community Hub metadata requests a public IP.

For local catalog testing:

```bash
ewc hub --path-to-catalog ./catalog/custom_catalog.yml deploy flexpart-ifs
```

## Configure MARS

On the VM, add your personal ECMWF credentials to:

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

The same playbook can configure an existing ECMWF-side Ubuntu VM:

```bash
cp inventory.example.yml inventory.yml
ansible-galaxy install -r requirements.yml
ansible-playbook -i inventory.yml deploy.yml
```

## License

The deployment code and documentation are licensed under the Apache License
2.0. Deployed components retain their own licences; see
[THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).
