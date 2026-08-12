# Troubleshooting

## EWCCLI creates Rocky instead of Ubuntu

This blueprint relies on `defaultImageName: Ubuntu-24.04`, which is consumed by
EWCCLI 0.7.1 and newer. Check the installed version:

```bash
ewc version
```

When testing the local catalogue, the deployment summary should show an Ubuntu
24.04 image. Users may still override the item default explicitly with
`--image-name` when appropriate.

## Ansible tries a private 192.168.x.x address

EWCCLI 0.7.1 and newer can allocate an external IP for this item through
`externalIP: true` and use that address for the Ansible phase. If no external IP
is available, check floating-IP quota, external-network configuration and the
EWCCLI deployment output.

If the external IP is reachable only through a corporate proxy/VPN/bastion,
configure that on the calling machine. The blueprint intentionally does not
hard-code organisation-specific SSH routing.

## ECMWF Data Flavour bootstrap fails on a non-Ubuntu host

The automatic Data Flavour bootstrap follows the upstream Ubuntu deployment
path. Use Ubuntu 24.04, or provide a functioning native `mars` client before
running this blueprint on another supported distribution.

## Docker is unavailable

```bash
sudo systemctl status docker
sudo journalctl -u docker --since today
```

## MARS access fails

Confirm that `mars` is installed and that the workflow operator has valid ECMWF
credentials and data entitlements. Never paste credentials into issue reports.

## Scientific stage fails

Collect the orchestrator, flexprep, FLEXPART and Pyflexplot logs separately.
Record the component image digest and the resolved run configuration.
