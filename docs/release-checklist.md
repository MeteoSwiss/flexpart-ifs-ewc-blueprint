# Release checklist

## Source and licensing

- [ ] Repository is public or accessible to intended users.
- [ ] Apache-2.0 `LICENSE` is present.
- [ ] All third-party licences are verified.
- [ ] Maintainer and support channel are documented.

## Reproducibility

- [ ] All component commits and versions are recorded.
- [ ] Container tags are immutable or image digests are recorded.
- [ ] No production deployment relies on a `main` or `latest` reference.
- [ ] The supported EWC image and flavor are confirmed.

## Security

- [ ] No credentials are present in Git history.
- [ ] Secret files are excluded from Git.
- [ ] Log output does not reveal credentials.
- [ ] Docker socket access by the orchestrator has been risk-reviewed.

## Deployment

- [ ] Direct Ansible installation succeeds on a clean VM.
- [ ] EWC CLI custom-catalog deployment succeeds.
- [ ] Manual workflow execution succeeds.
- [ ] Optional Aviso execution succeeds.
- [ ] Cleanup and restart procedures are tested.

## Reference case

- [ ] Scientifically approved configuration is committed.
- [ ] Expected outputs are documented.
- [ ] A dispersion plot is generated.
- [ ] Runtime and disk use are recorded.
- [ ] A second user completes the test without developer intervention.

## Publication

- [ ] `custom_catalog.yml` validates against the current schema.
- [ ] Repository URLs point to a tagged release.
- [ ] Community Hub description and inputs are accurate.
- [ ] Changelog is updated.
- [ ] Release tag is created.
