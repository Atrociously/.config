# .config
My common .config files across my linux installations.

## New installation steps
1. Install `neovim`
2. Install `nushell`
3. Install `zellij`
4. Install `alacritty`
5. Install `spotifyd`
   - Requires `pulseaudio` or `pipewire` with `pipewire-pulse` (prefer pipewire when possible)
6. Depending on the distro install `awesome` window manager
   - Requires a display manager like `lightdm`, `sddm` or `gdm`
     - `lightdm` will require a greeter like `lightdm-gtk-greeter`
   - Requres `dmenu` to run programs by searching for them
   - Requires `dex` to autostart programs in the `/etc/xdg/autostart/` directory
   - Requires `FiraCode Nerd Font` for the font can be changed in the awesome config

### Distro specific commands
#### Void
```sh
sudo xbps-install git
git clone git@github.com:Atrociously/.config.git $HOME/.config
sudo xbps-install -Sy neovim nushell zellij alacritty pipewire wireplumber xorg freefont-ttf socklog-void elogind spotifyd lightdm lightdm-gtk-greeter dmenu dex awesome
sudo ln -s /etc/sv/dbus /var/service/
sudo ln -s /etc/sv/dhcpcd /var/service/
sudo ln -s /etc/sv/elogind /var/service/
sudo ln -s /etc/sv/lightdm /var/service/
sudo ln -s /etc/sv/socklog-unix /var/service/
sudo ln -s /usr/share/applications/pipewire.desktop
sudo ln -s /usr/share/applications/pipewire-pulse.desktop
```


## Other useful software
- `helvum` - A pipewire patchbay
- `flameshot` - A screenshotting tool that stays in the tray
- `thunar` - A file browser
- `libreoffice` - A suite of office tools
