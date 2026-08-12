# Prerequisites

## EWC project

- Active EWC access and a target project/tenancy.
- Permission to create or access a virtual machine.
- A private network with outbound internet access.
- Permission/quota for an external/floating IP when using the EWCCLI one-command deployment.
- An SSH key accepted by the target VM.
- Storage suitable for the workflow.

## Recommended VM target

- Ubuntu 24.04 (the default for EWCCLI deployment of this blueprint).
- 8 vCPU.
- 16 GiB memory.
- At least 30 GiB storage.

The local `system` and `docker` roles also support Rocky/RHEL-family hosts. However,
when the native MARS client is missing, the automatic ECMWF Data Flavour 2.0.2
bootstrap follows the upstream Ubuntu deployment path. A non-Ubuntu existing VM
therefore needs a working native `mars` client before this blueprint is applied.

## External access

Confirm access to:

- the container registry;
- ECMWF MARS services;
- the public Git repositories used during installation.

If your organisation requires an SSH proxy, VPN or bastion to reach EWC external
IPs, configure that locally in your SSH/Ansible environment. Do not commit a
site-specific proxy to this blueprint.

## Local deployment tools

- EWCCLI 0.7.1 or newer for one-command VM provisioning from the custom catalogue; or
- Ansible for configuring an existing VM.
- SSH access to the VM.
