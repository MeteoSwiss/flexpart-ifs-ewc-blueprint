# Running and operating

After the real images and orchestrator command have been configured:

```bash
sudo -u flexpart /opt/flexpart-ifs/scripts/workflow-control.sh config
sudo -u flexpart /opt/flexpart-ifs/scripts/workflow-control.sh pull
sudo -u flexpart /opt/flexpart-ifs/scripts/workflow-control.sh start
sudo -u flexpart /opt/flexpart-ifs/scripts/workflow-control.sh status
sudo -u flexpart /opt/flexpart-ifs/scripts/workflow-control.sh logs orchestrator
```

The final project must add the confirmed command for launching a manual run and the command or service definition for starting the Aviso listener.

Logs belong under `/var/log/flexpart-ifs`; working data and local outputs belong under `/var/lib/flexpart-ifs` unless configured otherwise.
