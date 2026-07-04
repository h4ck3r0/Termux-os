<p align="center">
  <img src="https://user-images.githubusercontent.com/46929618/150730092-337cd5de-f376-454a-9418-c884bdb5f5e0.png" width="900">
</p>
<p align="center">
  <img src="https://img.shields.io/badge/Tool-Termux--OS-green?style=flat-square">
  <img src="https://img.shields.io/badge/Version-3.5-green?style=flat-square">
  <img src="https://img.shields.io/badge/Maintained-Yes-green?style=flat-square">
</p>
<p align="center">
  <a href="https://github.com/h4ck3r0">
    <img src="https://img.shields.io/badge/H4CK3R-Raj-brightgreen?style=for-the-badge&logo=github">
  </a>
  <a href="https://youtu.be/VDeLnDxVziw">
    <img src="https://img.shields.io/badge/YouTube-H4CK3R-red?style=for-the-badge&logo=youtube">
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Made%20with-Bash-blue?style=flat-square">
  <img src="https://img.shields.io/github/followers/h4ck3r0?style=flat-square">
  <img src="https://img.shields.io/github/stars/h4ck3r0/Termux-os?style=flat-square">
  <img src="https://img.shields.io/github/forks/h4ck3r0/Termux-os?style=flat-square">
  <img src="https://img.shields.io/github/watchers/h4ck3r0/Termux-os?style=flat-square">
  <img src="https://img.shields.io/badge/License-GNU-blue?style=flat-square">
</p>

---

## Termux-OS

**Termux-OS** is a menu-driven theme and shell customization tool for Termux.  
It focuses on improving usability and appearance while keeping setup simple and automated.

**Highlights**
- **NEW:** Curated Termux color schemes (Dracula, Nord, Monokai, Solarized Dark, and Default)
- **NEW:** Bash Shell customization (Syntax Highlighting & Auto-suggestions powered by `ble.sh` Line Editor)
- **NEW:** Secure Cyber Lock (compares SHA-256 hashes instead of plaintext keys in rc files)
- Zsh, Fish, and Bash shell support
- Clean and minimal Termux look
- One-click configuration

---

## Features

### 🔒 Cyber Lock System (Security)
Secure your terminal with a login gate. If the password is failed 3 times, the session auto-closes. Easily install or remove from the menu. Access keys are securely hashed using SHA-256 for protection.
<p align="center">
  <img src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiQpAEhEZoOyNzsfpBAC8BMjJfc-8XRzVWYGY8GzE2-y9gvl4ylhPIrqC9cYhkV2dCXoEAZBSEUF00LEiGQIvJUAA_Kj849C8A6ONdUuciYYduEzjyZfruoYVsRF4P/s600/Screenshot_20220122-163024.jpg" width="300">
</p>


### Extra Termux Keys
<p align="center">
  <img src="https://user-images.githubusercontent.com/46929618/150729794-17dd4f17-19d0-4028-99b8-c7a88994d145.jpg" width="300">
</p>

### Custom Username Banner
<p align="center">
  <img src="https://user-images.githubusercontent.com/46929618/150729923-9f0415aa-d0fd-46c7-86cb-1ef65affffcb.jpg" width="300">
</p>

### Custom Zsh, Fish, and Bash Themes
<p align="center">
  <img src="https://user-images.githubusercontent.com/46929618/150729435-7eea5d74-8474-427a-9ada-a8d50da91136.jpg" width="300">
</p>

### Syntax Highlighting & Autosuggestions (Zsh, Fish, & Bash)
Fully supported across Zsh (plugins), Fish (native), and Bash (powered by `ble.sh`).
<p align="center">
  <img src="https://user-images.githubusercontent.com/46929618/150729854-a09be75c-5e3a-4a21-85b4-71191ee42bd2.jpg" width="300">
</p>

### 🎨 Curated Termux Color Themes
Select and dynamically apply any of the 5 curated color themes:
- **Default (Gunmetal Neon)**
- **Dracula**
- **Nord**
- **Monokai**
- **Solarized Dark**

---

## Theme Preview

<p align="center">
  <img src="https://user-images.githubusercontent.com/46929618/150729988-7c0c2a39-fe78-4dc6-8174-1a220e0ee1e5.jpg" width="300">
</p>

---

## Installation

```bash
git clone https://github.com/h4ck3r0/Termux-os
cd Termux-os
bash os.sh

```

📺 **Full Installation Video:** [https://youtu.be/VSG2glraCws](https://youtu.be/VSG2glraCws)

📖 **Detailed Guide:** [https://www.h4ck3r.me/how-to-install-theme-in-termux-in-one-click/](https://www.h4ck3r.me/how-to-install-theme-in-termux-in-one-click/)

---

## Usage Guide

### 🚀 Getting Started

After running `bash os.sh`, you'll be presented with an interactive menu. Follow these steps:

1. **Start the installer**: The main menu will display all available options
2. **Select your shell**: Choose between Zsh, Fish, or Bash
3. **Customize your setup**: Pick theme, colors, and additional features
4. **Apply changes**: Restart Termux to see the changes

### 📋 Main Menu Options

```
╔════════════════════════════════════════╗
║     Termux-OS Menu                    ║
╠════════════════════════════════════════╣
║ 1. Install Zsh Theme                  ║
║ 2. Install Fish Theme                 ║
║ 3. Install Bash Theme                 ║
║ 4. Apply Color Theme                  ║
║ 5. Setup Cyber Lock                   ║
║ 6. Custom Username Banner             ║
║ 7. Exit                               ║
╚════════════════════════════════════════╝
```

### 🎨 Applying Color Themes

To apply a color theme:

1. Select **Option 4 - Apply Color Theme** from the main menu
2. Choose from the available themes:
   - `1` - Default (Gunmetal Neon)
   - `2` - Dracula
   - `3` - Nord
   - `4` - Monokai
   - `5` - Solarized Dark
3. The theme will be applied immediately to your Termux properties
4. Exit and reopen Termux to see the full effect

### 🔒 Setting Up Cyber Lock

**Security Feature:** Protect your Termux with a secure password gate

**Installation:**
1. Select **Option 5 - Setup Cyber Lock** from the main menu
2. Enter a password when prompted
3. Confirm the password
4. The lock will be activated on your next session

**How it works:**
- Password is hashed using SHA-256 (not stored in plaintext)
- Maximum 3 failed attempts before auto-logout
- Secure authentication on every shell startup

**To Remove Cyber Lock:**
1. Return to the main menu
2. Select **Option 5** again
3. Choose the remove/disable option
4. Confirm your current password

### 🐚 Shell Customization

#### Bash with Syntax Highlighting & Auto-suggestions
- **Powered by:** `ble.sh` Line Editor
- **Features:** Real-time syntax highlighting, intelligent command suggestions
- **Install:** Select **Option 3 - Install Bash Theme** and follow prompts

#### Zsh Customization
- **Features:** Auto-completion, plugin support, advanced theming
- **Install:** Select **Option 1 - Install Zsh Theme**
- **Plugins included:** Syntax highlighting, auto-suggestions, history search

#### Fish Shell
- **Features:** User-friendly, built-in auto-suggestions, native syntax highlighting
- **Install:** Select **Option 2 - Install Fish Theme**

### 👤 Custom Username Banner

Add a personalized ASCII banner to your terminal:

1. Select **Option 6 - Custom Username Banner**
2. Enter your desired username/text
3. Choose an ASCII art style
4. The banner will appear on every new session

### ⚙️ Configuration Files

After installation, configuration files are stored in:

- **Zsh config:** `~/.zshrc`
- **Bash config:** `~/.bashrc`
- **Fish config:** `~/.config/fish/config.fish`
- **Termux properties:** `~/.termux/properties`
- **Cyber Lock config:** `~/.termux/.secure`

### 🔄 Resetting to Defaults

To reset your configuration:

```bash
# Backup current config (optional)
cp ~/.zshrc ~/.zshrc.backup

# Run the installer again and choose default options
bash os.sh
```

### 🐛 Troubleshooting

**Theme not applying?**
- Ensure Termux is fully closed and reopened
- Check that `~/.termux/properties` has correct permissions
- Try applying a different theme first, then your desired theme

**Cyber Lock not working?**
- Verify password was set correctly (check for typos)
- Ensure `~/.termux/.secure` file exists and has correct permissions
- Reinstall Cyber Lock if issues persist

**Shell customization not visible?**
- Restart Termux completely
- Check that the appropriate rc file (`~/.zshrc`, `~/.bashrc`, etc.) was modified
- Run `bash os.sh` again and reinstall

### 💡 Tips & Tricks

1. **Combine Features:** Use Cyber Lock + Custom Banner + Color Theme together
2. **Fast Switching:** Quickly change themes by running `bash os.sh` again
3. **Backup Configs:** Always backup before major updates
4. **Performance:** Bash with ble.sh may use slightly more resources; adjust if needed

---

## Credits

* Oh My Zsh
* Fish Shell Community
* Raj Aryan (H4CK3R)

---

## Connect

<p>
<a href="https://github.com/h4ck3r0">
<img src="https://img.shields.io/badge/GitHub-H4CK3R-green?style=for-the-badge&logo=github">
</a>
<a href="https://www.h4ck3r.me">
<img src="https://img.shields.io/badge/Website-Visit-yellow?style=for-the-badge">
</a>
<a href="https://t.me/h4ck3r_group">
<img src="https://img.shields.io/badge/Telegram-Channel-blue?style=for-the-badge&logo=telegram">
</a>
<a href="https://rebrand.ly/7elzgww">
<img src="https://img.shields.io/badge/YouTube-H4CK3R-red?style=for-the-badge&logo=youtube">
</a>
</p>
