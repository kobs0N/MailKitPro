#!/bin/bash

# Check if run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Check for domain name argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <yourdomain.com>"
    exit 1
fi

DOMAIN=$1

# Update and install Postfix and OpenDKIM
apt-get update
apt-get install -y postfix opendkim opendkim-tools

# Configure Postfix
POSTFIX_MAIN_CF="/etc/postfix/main.cf"
echo "Updating Postfix configuration..."
cat <<EOF >> $POSTFIX_MAIN_CF
myhostname = mail.$DOMAIN
mydomain = $DOMAIN
myorigin = \$mydomain
relayhost =
mynetworks = 127.0.0.0/8 [::1]/128
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = all
inet_protocols = all
EOF

# Configure OpenDKIM
echo "Configuring OpenDKIM..."
mkdir -p /etc/opendkim/keys/$DOMAIN
opendkim-genkey -b 2048 -h rsa-sha256 -r -s mail -d $DOMAIN
mv mail.private /etc/opendkim/keys/$DOMAIN/private.key
mv mail.txt /etc/opendkim/keys/$DOMAIN/
chown -R opendkim:opendkim /etc/opendkim/keys/$DOMAIN

# OpenDKIM main configuration
OPENDKIM_CONF="/etc/opendkim.conf"
cat <<EOF >> $OPENDKIM_CONF
Domain                  $DOMAIN
KeyFile                 /etc/opendkim/keys/$DOMAIN/private.key
Selector                mail
EOF

# Restart services
echo "Restarting services..."
systemctl restart postfix
systemctl restart opendkim

# Display DNS record
echo "Add the following DNS record for DKIM:"
cat /etc/opendkim/keys/$DOMAIN/mail.txt

echo "Setup complete. Please verify DNS record and test your setup."
