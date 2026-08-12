# Prerequisites

## EWC project

- Active EWC access and a target project/tenancy.
- Permission to create or access a virtual machine.
- A private network with outbound internet access.
- An SSH key accepted by the target VM.
- Storage or bucket access suitable for the workflow.

## Initial VM target

- Ubuntu 22.04 or Rocky Linux 9 (the EWCCLI default tested here).
- 8 vCPU.
- 16 GiB memory.
- At least 30 GiB storage.

## External access

Confirm access to:

- the container registry;
- IFS/FDB services or the approved input bucket;
- Aviso when event-driven execution is enabled;
- the EWC S3-compatible endpoint.

## Local deployment tools

- Ansible for direct testing, or a compatible EWC CLI release.
- SSH access to the VM.
