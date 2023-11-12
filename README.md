# MailKitPro

MailKitPro is a simple yet powerful bash script designed to automate the setup of SMTP and DKIM on Linux servers. It streamlines the installation and basic configuration of Postfix and OpenDKIM, requiring just your domain name to set everything up.

## Features

- 📧 Easy SMTP setup with Postfix.
- 🔒 DKIM (DomainKeys Identified Mail) configuration for email authentication.
- 🛠️ Automatic generation of DKIM keys.
- ✅ Minimal input required - just your domain name.

## Prerequisites

- A Linux server (Debian/Ubuntu recommended).
- Root access to the server.
- A domain name with access to modify DNS records.

## Installation

1. **Download the Script**: Clone the repository or download `mailkitpro.sh` directly.
   ```bash
   git clone https://github.com/kobs0N/MailKitPro.git
   ```
   or
   
   ```bash
   wget https://raw.githubusercontent.com/kobs0N/MailKitPro/main/mailkitpro.sh
   ```

3. **Make it Executable**: Change the script's permissions to make it executable.
   ```bash
   chmod +x mailkitpro.sh
   ```

## Usage

To run MailKitPro, simply execute the script with your domain name as an argument:

```bash
sudo ./mailkitpro.sh yourdomain.com
```

Follow the on-screen instructions. After the script completes, you will be provided with a DNS record to add to your domain's DNS settings for DKIM to function correctly.

## Post-Installation

- **Verify DNS**: Add the provided DNS record to your domain's DNS settings.
- **Test Email Setup**: Send a test email to ensure SMTP and DKIM are configured correctly.
