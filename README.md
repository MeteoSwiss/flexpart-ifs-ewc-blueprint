# FLEXPART-IFS EWC Blueprint

This repository deploys a FLEXPART-IFS workflow on an existing European Weather Cloud (EWC) Ubuntu VM.

The deployed workflow does this:

```text
ECMWF MARS
    ↓
flexprep
    ↓
FLEXPART-IFS
    ↓
Pyflexplot
    ↓
PDF plots
```

Meteorological input is retrieved directly from ECMWF MARS. FLEXPART and Pyflexplot run in containers, while the orchestrator and flexprep run on the VM.

## What the blueprint installs

Ansible installs:

- Docker and Docker Compose;
- `flex-container-orchestrator` as a Python virtual environment;
- `/usr/local/bin/flexpart-workflow`;
- `/etc/flexpart-ifs/workflow.yml`;
- `/opt/flexpart-ifs/compose.yml`;
- runtime directories under `/var/lib/flexpart-ifs`;
- the public container image references:
  - `docker.io/ninaburg/flexpart-ifs:10.5.0`
  - `docker.io/ninaburg/pyflexplot:2.7.1`

No Docker Hub login is required for these public images.

## Prerequisites

You need:

- an existing Ubuntu EWC VM;
- SSH access to the VM;
- Ansible on the machine from which you deploy;
- a working ECMWF MARS client on the EWC VM;
- permission to retrieve the required operational IFS data from MARS.

The blueprint does not provide MARS permissions or credentials.

## Deploy

Copy the example inventory:

```bash
cp inventory.example.yml inventory.yml
```

Edit `inventory.yml` with the VM address, SSH user and private key.

Then deploy:

```bash
ansible-galaxy install -r requirements.yml
ansible-playbook -i inventory.yml deploy.yml
```

After the first deployment, log out of the VM and SSH in again so the updated Docker group membership is active.

## Run

For the latest complete IFS forecast cycle:

```bash
flexpart-workflow \
  --latest \
  --step 24 \
  --location BEZ
```

For a specific forecast cycle:

```bash
flexpart-workflow \
  --date 20260810 \
  --time 00 \
  --step 24 \
  --location BEZ
```

`--location` is a predefined release site supported by the FLEXPART runtime configuration.

For a quick test, use a shorter forecast duration such as:

```bash
flexpart-workflow --latest --step 4 --location BEZ
```

## Results

The workflow keeps its outputs on the VM:

```text
/var/lib/flexpart-ifs/
├── meteorology/   # prepared IFS files (dispf*.grib)
├── runs/          # FLEXPART jobs and NetCDF output
└── plots/         # Pyflexplot PDF plots
```

List the generated PDFs with:

```bash
find /var/lib/flexpart-ifs/plots -type f -name '*.pdf' -print
```

## Configuration

The deployed configuration is:

```text
/etc/flexpart-ifs/workflow.yml
```

Forecast cycle, forecast duration and release site are intentionally selected when the workflow is run; they are not fixed by the blueprint.

The main deployment variables are in:

```text
group_vars/all.yml
```

This includes the orchestrator version, container image versions, MARS preprocessing area/grid and output paths.

## Current prototype versions

- FLEXPART-IFS image: `10.5.0`
- Pyflexplot image: `2.7.1`
- flexprep: installed as a dependency of the orchestrator
- orchestrator: `feat/ewc-blueprint-runtime`

Before a final Community Hub release, pin the orchestrator to a release tag or commit instead of the feature branch.

## License

The deployment code and documentation in this repository are licensed under the Apache License 2.0. See [LICENSE](LICENSE).

The deployed components retain their own licences. See [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).
