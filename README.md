# dotfiles

Personal Linux dotfiles: i3, polybar, picom, kitty, zsh.

## Install

```sh
./install.sh
```

Symlinks each config into place (`kitty`, `i3`, `polybar`, `picom` → `~/.config/`, `.zshrc` → `~/`), backing up any existing target to `*.bak`. Re-run it after pulling if paths have moved. Linux only — it aborts elsewhere.

## Required but not in git

These need to exist on the machine; the configs reference them:

- **Packages**: `i3`, `polybar`, `picom`, `kitty`, `rofi`, `feh`, `i3lock`, `xss-lock`, `nm-applet`, `dex`, `maim`, `xclip`, `ckb-next`, and PulseAudio/PipeWire (`pactl`).
- **oh-my-zsh** at `~/.oh-my-zsh` (`.zshrc` sources it; plugins: `git`, `python`, `ssh-agent`).
- **Fonts**: `VictorMono Nerd Font Mono` (kitty), `Roboto Condensed`, `Font Awesome 6` (Free/Solid/Brands), `UbuntuMono Nerd Font` (polybar).
- **Wallpapers**: `~/pictures/wallpapers/wallpaper_big.jpg`, `~/pictures/wallpapers/vertical_wallpaper.jpg`, and `~/pictures/wallpaper.png` (lock screen).
- **Scripts/apps** launched by i3 keybinds: `~/code/scripts/launchwow.sh`, plus `firefox`, `discord`, `spotify-launcher`.

## Machine-specific

- Polybar wifi: set `interface` in `polybar/modules.ini` (`[module/wlan]`) to your device (`ip link`).
- Monitor layout: the `xrandr` line in `i3/config` is hardcoded to specific outputs — edit for your setup.
