# FLEXPART-IFS EWC Blueprint

Deploy FLEXPART-IFS on the European Weather Cloud (EWC).

> **Note:** This blueprint is supported and tested only on the ECMWF side of
> the European Weather Cloud.

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

## License

The deployment code and documentation are licensed under the Apache License
2.0. Deployed components retain their own licences; see
[THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).
