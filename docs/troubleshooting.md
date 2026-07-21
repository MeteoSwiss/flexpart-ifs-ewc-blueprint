# Troubleshooting

## Placeholders remain

Search the installed configuration:

```bash
grep -R "REPLACE_BEFORE" /opt/flexpart-ifs
```

Replace all relevant values before pulling or starting containers.

## Docker is unavailable

```bash
sudo systemctl status docker
sudo journalctl -u docker --since today
```

## Registry access fails

Confirm the image address, network access and registry authentication. Avoid using mutable `latest` tags.

## S3 access fails

Confirm endpoint, bucket names, credentials, certificate trust and network access. Never paste secret values into issue reports.

## Aviso event is not received

Run the workflow manually first. Confirm the Aviso endpoint, event filter, authentication, listener logs and retry behaviour before enabling operational mode.

## Scientific stage fails

Collect the orchestrator, Flexprep, FLEXPART and Pyflexplot logs separately. Record the component image digest and the resolved run configuration.
