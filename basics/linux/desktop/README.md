# basic desktop customization

## Here's a full script to install GNOME Shell extensions and related tools on a Debian/Ubuntu-based system. It includes the installation of:

* Installs base packages for GNOME Shell extension support
* Installs Extension Manager (GUI)
* Installs and enables the following extensions:
    * Dash to Dock
    * Blur My Shell
    * User Themes
    * Just Perfection
    * Vitals
    * Clipboard Indicator
    * Caffeine
    * Night Theme Switcher
    * GSConnect
    * Media Controls
    * OpenWeather
    * Bluetooth Quick Connect
* Installs additional tools: gnome-tweaks, dconf-editor

## Instructions:
* 1. You can copy and paste the following into your terminal:


<details>
<summary>basic-desktop-instalation.sh</summary>

```bash

#!/bin/bash

set -e

echo "Updating system and installing GNOME extension support..."
sudo apt update
sudo apt install -y \
  gnome-shell-extensions \
  gnome-shell-extension-prefs \
  chrome-gnome-shell \
  curl \
  jq \
  unzip \
  gnome-tweaks \
  dconf-editor

echo "Installing Extension Manager (Flatpak)..."
flatpak install -y flathub com.mattjakeman.ExtensionManager

EXTENSIONS_DIR="$HOME/.local/share/gnome-shell/extensions"
mkdir -p "$EXTENSIONS_DIR"

install_gnome_extension() {
  EXTENSION_ID=$1
  EXTENSION_NAME=$2

  echo "Installing $EXTENSION_NAME (ID $EXTENSION_ID)..."

  UUID=$(curl -s "https://extensions.gnome.org/extension-info/?pk=$EXTENSION_ID" | jq -r .uuid)
  SHELL_VERSION=$(gnome-shell --version | grep -oP '\d+\.\d+' | head -1)
  VERSION_TAG=$(curl -s "https://extensions.gnome.org/extension-info/?pk=$EXTENSION_ID" | jq -r '.shell_version_map["'"$SHELL_VERSION"'"] // .shell_version_map | keys[0]')
  DOWNLOAD_URL="https://extensions.gnome.org/download-extension/$UUID.shell-extension.zip?version_tag=$VERSION_TAG"

  DEST="$EXTENSIONS_DIR/$UUID"
  mkdir -p "$DEST"
  curl -L "$DOWNLOAD_URL" -o "$DEST/extension.zip"
  unzip -o "$DEST/extension.zip" -d "$DEST"
  rm "$DEST/extension.zip"

  gnome-extensions enable "$UUID" || echo "Manual activation may be required for $UUID"
}

# List of extensions to install (ID Name)
EXTENSIONS=(
  "307 Dash_to_Dock"
  "3193 Blur_My_Shell"
  "19 User_Themes"
  "3843 Just_Perfection"
  "1460 Vitals"
  "779 Clipboard_Indicator"
  "517 Caffeine"
  "2236 Night_Theme_Switcher"
  "1319 GSConnect"
  "358 Media_Controls"
  "750 OpenWeather"
  "1401 Bluetooth_Quick_Connect"
)

for item in "${EXTENSIONS[@]}"; do
  install_gnome_extension $item
done

echo "All extensions downloaded and enabled."

echo "Attempting to reload GNOME Shell (works only on X11)..."
busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'global.reexec_self()' || true

echo "Done. You can manage your extensions via 'Extension Manager' or 'gnome-extensions-app'."


```

</details>

* 2. You can download the script:

[basic-desktop-instalation.sh](./bdesktopi.sh)

and run:

```bash

chmod +x bdesktopi.sh
./bdesktopi.sh

```

## Requirements

- Debian-based system
- GNOME Shell
- Flatpak enabled