# Configuration

## Ansible variables

The default variables are in `group_vars/all.yml` and role `defaults/main.yml` files.

The most important values are:

| Variable | Purpose |
|---|---|
| `flexpart_orchestrator_image` | Pinned orchestrator image |
| `flexprep_image` | Pinned preprocessing image |
| `flexpart_model_image` | Pinned FLEXPART image |
| `pyflexplot_image` | Pinned plotting image |
| `flexpart_orchestrator_command` | Real orchestrator entry command |
| `flexpart_workflow_mode` | `manual` or `aviso` |
| `flexpart_s3_endpoint_url` | EWC S3-compatible endpoint |
| `flexpart_*_bucket` | Input and output bucket names |
| `flexpart_pull_images` | Pull images during deployment |
| `flexpart_start_services` | Start orchestrator during deployment |

## Secrets

Never put secret values in `group_vars/all.yml`, the catalog file or committed configuration. Use the protected target file `/opt/flexpart-ifs/config/secrets.env`, Ansible Vault or the approved organizational mechanism.

## Project-specific work still required

Document the exact environment-variable and file interfaces expected by each real container. The current templates are a safe integration skeleton, not a confirmed representation of the existing PoC interfaces.
