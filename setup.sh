#!/usr/bin/env bash
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"
msg() {
  case "$1" in
  error)
    printf '%s\n' "${RED}[ERROR]:${RESET} $2"
    ;;
  success)
    printf '%s\n' "${GREEN}[SUCCESS]:${RESET} $2"
    ;;
  debug)
    printf '%s\n' "${BLUE}[DEBUG]:${RESET} $2"
    ;;
  esac
}

package_list=(
  # Core
  "base-devel"
  "sof-firmware"
  "networkmanager"
  "git"
  "stow"
  # Fonts
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-emoji"
  "ttf-jetbrains-mono-nerd"
  "terminus-font"
  # Desktop utilities
  "rofi"
  "rofimoji"
  "kitty"
  "pcmanfm"
  "librewolf"
  "satty"
  "slurp"
  "grim"
  "brightnessctl"
  "swww"
  "zathura"
  "zathura-pdf-mupdf"
  "adw-gtk-theme"
  "cliphist"
  "gum"
  "fzf"
  "imv"
  "libappindicator"
  "nwg-look"
  "mako"
  "wl-clipboard"
  "swaylock-effects"
  "swayidle"
  # System utilities
  "xdg-user-dirs"
  "xdg-utils"
  "xdg-desktop-portal-gtk"
  "qt6-wayland"
  "qt5-wayland"
  "rsync"
  "shellcheck"
  "ripgrep"
  "npm"
  "man-db"
  # Multimedia
  "mpv"
  "ffmpeg"
  "v4l-utils"
  "pipewire"
  "pipewire-pulse"
  "pipewire-jack"
  "wireplumber"
  "pipewire-alsa"
  # Security
  "ufw"
  "wireguard-tools"
  # GPU/Drivers
  "vulkan-intel"
  "intel-media-driver"
  "intel-ucode"
  # Development
  "neovim"
  "lazygit"
  "fastfetch"
  "fd"
  "eza"
  "bat"
  "btop"
  "age"
  "jq"
  "gnome-themes-extra"
  "7zip"
)
sudo pacman -Sy --needed --noconfirm "${package_list[@]}"

if [ ! -d "$HOME/.config/niri" ]; then
  stow -t ~/.config/niri niri
else
  msg error "Directory niri doesn't exist."
  read -r -p "Make directory? (y/n) " dir_make
  select dir_make in "y" "n"; do
    if [ "$dir_make" == "y" ]; then
      mkdir "$HOME/.config/niri"
      stow -t ~/.config/niri niri
      msg success "Created directory niri and stowed files"
    fi
  done
fi

select qs_shell in "noctalia" "dms (Dank Material Shell)"; do
  if [ "$qs_shell" == "noctalia" ]; then
    systemctl --user add-wants niri.service noctalia.service
    systemctl --user enable noctalia.service
    break
  else
    systemctl --user enable dms
    systemctl --user start dms
    break
  fi
done

# Bash scripts git repo
git clone https://github.com/ryukamish/bash-utils.git ~/.local/bin

update-mime-database ~/.local/share/applications
# Mimetype default settings
xdg-mime default librewolf.desktop x-scheme-handler/http
xdg-mime default librewolf.desktop x-scheme-handler/https
# pdf reader
xdg-mime default zathura.desktop application/pdf
# image viewer
xdg-mime default imv.desktop image/png
xdg-mime default imv.desktop image/jpeg
xdg-mime default imv.desktop image/gif
xdg-mime default imv.desktop image/webp
xdg-mime default imv.desktop image/bmp
xdg-mime default imv.desktop image/tiff
# video player
xdg-mime default mpv.desktop video/mp4
xdg-mime default mpv.desktop video/x-msvideo
xdg-mime default mpv.desktop video/x-matroska
xdg-mime default mpv.desktop video/x-flv
xdg-mime default mpv.desktop video/x-ms-wmv
xdg-mime default mpv.desktop video/mpeg
xdg-mime default mpv.desktop video/webm
xdg-mime default mpv.desktop video/quicktime
xdg-mime default mpv.desktop video/3gpp
xdg-mime default mpv.desktop video/3gpp2
xdg-mime default mpv.desktop video/x-ms-asf
xdg-mime default mpv.desktop video/x-ogm+ogg
xdg-mime default mpv.desktop video/x-theora+ogg
xdg-mime default mpv.desktop application/ogg
