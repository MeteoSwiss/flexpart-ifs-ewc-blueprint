# Changelog

## Unreleased

- Require/recommend EWCCLI 0.7.1+ for custom-catalog provisioning.
- Default EWCCLI deployments to Ubuntu 24.04 and request an external IP.
- Keep site-specific SSH proxy/bastion configuration outside the blueprint.
- Support Debian/Ubuntu and Rocky/RHEL package management for local roles.
- Use the upstream ECMWF Data Flavour 2.0.2 repository-root requirements file.
- Restrict automatic ECMWF Data Flavour bootstrap to Ubuntu when MARS is absent.


All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and the project intends to use Semantic Versioning.

## [Unreleased]

### Added

- Initial repository scaffold.
- Ansible deployment roles for Ubuntu/Rocky Linux, Docker and workflow configuration.
- Docker Compose and configuration templates.
- Draft EWC Community Hub custom catalog entry.
- Documentation and reference-case skeleton.
