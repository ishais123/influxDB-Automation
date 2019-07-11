#!/bin/bash

# This script get all google cloud instances IP's using gcloud API and update Ansible hosts file

# This script run as a crontab task every 1 minute 
# To show details crontab task enter 'crontab -l'

# Build '/etc/ansible/hosts' file
echo "# This is the default ansible 'hosts' file." > /etc/ansible/hosts
echo "" >> /etc/ansible/hosts
echo "# It should live in /etc/ansible/hosts" >> /etc/ansible/hosts
echo "" >> /etc/ansible/hosts
echo "# You can find an examples of how to add hosts to this file in '/etc/ansbile/exmaples' file" >> /etc/ansible/hosts
echo "" >> /etc/ansible/hosts

# Create a new group for google cloud instances
echo "[gcp]" >> /etc/ansible/hosts
echo "" >> /etc/ansible/hosts

# Add Google cloud instances's IP's to '/etc/ansible/hosts' file
gcloud compute instances list --format "get(networkInterfaces[0].accessConfigs[0].natIP)" >> /etc/ansible/hosts


# Send an update log to /var/log/syslog with all script details
logger -i -p local3.info -t gcloud_ip_to_ansible.sh "All GCP instances's IP's updated in '/etc/ansible/hosts' file according to current instances list in GCP"