# FLEXPART-IFS EWC Blueprint

Deployment blueprint for running the end-to-end FLEXPART-IFS dispersion workflow on the European Weather Cloud (EWC).

The repository installs and configures the containerized workflow on an EWC Ubuntu virtual machine. It is intended to become an EWC Community Hub item deployable with the EWC CLI.

## Current status

**Initial scaffold - not yet released.**

TODO: Before the first deployment, replace every `REPLACE_BEFORE_DEPLOYMENT` value and confirm the interfaces of:

* `flex-container-orchestrator`
* `flexprep` / `preflexpart`
* `FLEXPART-IFS`
* `pyflexplot`
* MARS, S3 and local-file data access
* Optional Aviso triggering
* S3-compatible output storage

## Intended architecture

```text
Aviso event or manual request
            |
            v
flex-container-orchestrator
            |
            v
     Select input mode
            |
      +-----+-----+
      |     |     |
      v     v     v
    MARS    S3   Local files
      |     |     |
      +-----+-----+
            |
            v
      raw IFS data
            |
            v
 flexprep / preflexpart
            |
            v
    prepared IFS data
            |
            v
      FLEXPART-IFS
            |
            v
   dispersion outputs
            |
            v
        pyflexplot
            |
            v
    dispersion plots
```

Meteorological inputs are retrieved from MARS, downloaded from user-configured S3-compatible storage, or supplied from local directories.

Outputs are stored in user-configured S3-compatible buckets or local directories.

Aviso is optional and is used to trigger the workflow; it does not retrieve the meteorological data.

## Repository contents

* `deploy.yml`: main Ansible playbook used by EWC CLI.
* `requirements.yml`: Ansible dependencies.
* `roles/`: host setup, Docker installation, workflow installation and validation.
* `templates/`: generated Docker Compose and workflow configuration.
* `config/`: user-facing configuration examples for MARS, S3, local files, Aviso and secrets.
* `catalog/custom_catalog.yml`: draft metadata for testing through an EWC CLI custom catalog.
* `examples/reference-case/`: skeleton of the end-to-end acceptance test.
* `docs/`: installation, configuration, architecture, operation and troubleshooting guidance.

## Supported initial target

| Resource         |                        Initial recommendation |
| ---------------- | --------------------------------------------: |
| Operating system |                                  Ubuntu 22.04 |
| CPU              |                                        8 vCPU |
| Memory           |                                        16 GiB |
| Storage          |                               At least 30 GiB |
| Network          | Private network with outbound internet access |

These values come from the original proof-of-concept environment and must be confirmed during clean-project testing.

## Quick start on an existing VM

1. Copy the repository to your workstation.

2. Copy and edit the example variables:

   ```bash
   cp inventory.example.yml inventory.yml
   cp config/secrets.env.example config/secrets.env
   ```

3. Select and configure one input mode:

   * `mars` for authorised MARS retrieval;
   * `s3` for existing disseminated IFS files;
   * `local` for development and testing.

4. Replace all image placeholders in `group_vars/all.yml` or pass them with `--extra-vars`.

5. Run:

   ```bash
   ansible-galaxy install -r requirements.yml
   ansible-playbook -i inventory.yml deploy.yml
   ```

6. Validate the installation on the target host:

   ```bash
   sudo /opt/flexpart-ifs/scripts/validate-environment.sh
   ```

By default, the scaffold does **not** pull or start the workflow images. Set the following only after the real image addresses and commands are confirmed:

```yaml
flexpart_pull_images: true
flexpart_start_services: true
```

## Test through the EWC CLI

Edit `catalog/custom_catalog.yml`, especially the repository URL, image/flavor names and maintainer details. Then use the custom catalog mechanism supported by your installed EWC CLI, for example:

```bash
ewc hub --path-to-catalog ./catalog/custom_catalog.yml show

ewc hub --path-to-catalog ./catalog/custom_catalog.yml deploy flexpart-ifs
```

Check the syntax against the installed EWC CLI release and the latest Community Hub metadata schema before submission.

## Configuration and secrets

Normal settings belong in YAML or Ansible variables. Credentials must not be committed. Use `config/secrets.env`, Ansible Vault or approved EWC secret-management mechanisms.

Only provide the credentials needed by the selected input mode:

* MARS credentials for `mars`;
* S3 credentials for `s3`;
* no remote data credentials for `local`.

MARS users must have permission to retrieve the required IFS data. MARS access is not automatically provided by deploying the workflow on EWC.

## Release readiness

A `v1.0.0` release should not be created until:

* all container images are publicly or appropriately accessible and pinned;
* the orchestrator command and interfaces are confirmed;
* the complete MARS request required by Preflexpart is verified;
* MARS, S3 and local-file input modes are validated;
* manual execution works without Aviso;
* optional Aviso execution works;
* the reference case completes on a clean EWC project;
* a second user can deploy using only the documentation;
* all third-party licences are verified.

## License

The deployment code and documentation in this repository are licensed under the Apache License 2.0. See [LICENSE](LICENSE).

The components deployed by the blueprint retain their own licences. See [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).
