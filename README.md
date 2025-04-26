
# 📖 Documentation

---

## 📋 Project Overview

**UfwRuler** is a lightweight terminal-based utility that helps you manage your server's firewall rules using `ufw` (Uncomplicated Firewall).  
It features:

- A simple **terminal UI** using `dialog`.
    
- **Templates** for quickly setting up firewall rules for common server types (SMTP, SFTP, etc.).
    
- **Default rules** to ensure basic server security.
    
- A **Composer** script for easy installation and setup.
    

---

## 🏗️ Project Structure

```
UfwRuler/
├── composer.sh            # First-time setup script (installs packages, sets permissions)
├── setup.sh               # Main interactive script (firewall manager)
├── packages/
│   └── requirements.txt   # List of required system packages (e.g., dialog, ufw)
└── templates/
    ├── smtp-rules.sh      # SMTP-specific firewall rules
    ├── sftp-rules.sh      # SFTP-specific firewall rules
    └── ...other templates
```

---

## 🚀 Quickstart Guide

1. **Clone or Download the UfwRuler folder.**
    
2. **Move UfwRuler to your server's `/opt/` directory.**  
    (recommended for clean system management)
    
    ```bash
    sudo mkdir -p /opt/UfwRuler
    sudo cp -r ./UfwRuler /opt/
    cd /opt/UfwRuler
    ```
    
3. **Run the Composer to install required packages and set up the environment.**
    
    ```bash
    chmod +x composer.sh
    ./composer.sh
    ```
    
4. **Follow the prompts to launch UfwRuler!**
    

---

## ⚙️ Features and Options

When you run `setup.sh`, you will be greeted with a **menu**:

|Option|Description|
|---|---|
|Set Default UFW Rules|Sets secure defaults (deny incoming, allow outgoing, SSH open)|
|Apply Service Template|Choose a template (e.g., SMTP, SFTP) to auto-apply firewall rules|
|Show UFW Status|View the current status and open ports|
|Enable UFW|Enable the firewall if not already active|
|Disable UFW|Disable the firewall|
|Exit|Exit UfwRuler|

---

## 📜 Templates Usage

Templates are simple `.sh` scripts inside the `templates/` folder.  
Each template defines firewall rules for specific server roles.

**Example: `smtp-rules.sh`**

```bash
#!/bin/bash
sudo ufw allow 25/tcp
sudo ufw allow 587/tcp
sudo ufw allow 465/tcp
echo "SMTP rules applied."
```

You can easily add your own custom templates!  
Just create a new `.sh` file inside the `templates/` folder following the same style.

---

## 🔒 Default Firewall Setup

When you choose **Set Default UFW Rules**, the following actions are performed:

- Deny all **incoming** traffic.
    
- Allow all **outgoing** traffic.
    
- Allow incoming **SSH** (port 22).
    

This ensures that:

✅ Your server is reachable for management.  
✅ Unwanted external connections are blocked by default.

---

## 📦 Requirements

UfwRuler needs:

- `ufw`
    
- `dialog`
    

These are automatically installed when you run `composer.sh`.

---

## 🛠️ Tips

- **Want faster access?** Add an alias:
    
    ```bash
    echo "alias ufwruler='/opt/UfwRuler/setup.sh'" >> ~/.bashrc
    source ~/.bashrc
    ```
    
    Then you can just type:
    
    ```bash
    ufwruler
    ```
    
- **Always reload UFW** after making manual changes:
    
    ```bash
    sudo ufw reload
    ```
    

---

## ❓ FAQ

**Q: Can I create my own service templates?**  
**A:** Yes! Just create a new `.sh` file inside `templates/`, and use `sudo ufw allow` or `sudo ufw deny` commands.

---

**Q: What happens if I enable UFW without any rules?**  
**A:** UfwRuler always ensures at least SSH (port 22) is open by default, so you don't lock yourself out.

---

**Q: Can I uninstall UfwRuler?**  
**A:** Just delete the `/opt/UfwRuler/` folder:

```bash
sudo rm -rf /opt/UfwRuler
```

If you added an alias, remove it manually from your `.bashrc`.

---

# 🧹 Clean, Simple, and Server-Friendly.

Enjoy managing your server safely and efficiently! 🛡️

---

# 📑 Example README Title

> **UfwRuler — Simple and Safe UFW Firewall Management Tool**

---

Would you also want me to generate a beautiful ready-to-copy **README.md** file you can drop into the project?  
📄✨ (Markdown styled, perfect for GitHub or your own docs!)  
If yes, I can generate it right away! 🚀
