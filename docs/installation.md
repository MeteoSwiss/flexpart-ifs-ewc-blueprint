# Installation

## Existing-VM installation

1. Create a supported EWC VM.
2. Ensure SSH access works.
3. Copy `inventory.example.yml` to `inventory.yml` and edit it.
4. Replace image and storage placeholders in `group_vars/all.yml`.
5. Install Ansible requirements:

   ```bash
   ansible-galaxy install -r requirements.yml
   ```

6. Run the playbook:

   ```bash
   ansible-playbook -i inventory.yml deploy.yml
   ```

7. Log in and edit the protected secret file:

   ```bash
   sudoedit /opt/flexpart-ifs/config/secrets.env
   ```

8. Validate:

   ```bash
   sudo /opt/flexpart-ifs/scripts/validate-environment.sh
   ```

## EWC CLI custom-catalog test

Edit `catalog/custom_catalog.yml`, then run the custom-catalog `show` and `deploy` operations supported by the installed EWC CLI version. Confirm the latest EWC catalog schema before testing.
