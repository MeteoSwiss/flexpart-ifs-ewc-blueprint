# Architecture

## Deployment boundary

The EWC CLI or an operator creates/selects the target Ubuntu or Rocky Linux VM. `deploy.yml` configures that VM. Package-management and Docker-repository tasks select the appropriate Debian- or RedHat-family path. The scientific components remain independently versioned container images.

## Runtime components

- **Flex Container Orchestrator:** receives a manual request or Aviso notification and coordinates the workflow.
- **Flexprep:** manages forecast availability and preprocessing operations.
- **Preflexpart:** transforms IFS data into FLEXPART meteorological input.
- **FLEXPART-IFS:** runs the dispersion simulation.
- **Pyflexplot:** generates dispersion visualizations.

## Storage

The intended storage layout uses separate logical locations for raw IFS data, preprocessed inputs, model output, plots and logs. Bucket creation is not implemented in the initial scaffold because the exact EWC S3 API and project policy must be confirmed.

## Trust boundaries

- EWC/OpenStack credentials stay on the user workstation or approved credential store.
- S3, FDB and Aviso secrets are installed separately with restrictive permissions.
- Container images must be pulled from an approved, accessible registry and pinned to a release tag or digest.
