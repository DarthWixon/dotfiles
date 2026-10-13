# dotfiles

Personal Linux dotfiles: sway, waybar, kitty, zsh, starship, plus i3, polybar and picom as an X fallback.

## Install

```sh
./install.sh
```

Renders colour templates (`colors/build.sh`), then symlinks each config into place (`colors`, `kitty`, `i3`, `sway`, `waybar`, `polybar`, `picom` → `~/.config/`, `.zshrc` → `~/`, `starship/starship.toml` → `~/.config/starship.toml`, `claude/CLAUDE.md` → `~/.claude/CLAUDE.md`), backing up any existing target to `*.bak`. Re-run it after pulling if paths have moved. Linux only — it aborts elsewhere.

## Required but not in git

These need to exist on the machine; the configs reference them:

- **Packages (sway)**: `sway`, `xorg-xwayland`, `swaybg`, `swaylock`, `swayidle`, `waybar`, `grim`, `slurp`, `wl-clipboard`, `xdg-desktop-portal-wlr` (screen sharing; needs `pipewire-pulse` and `wireplumber`), `qt5-wayland`, `qt6-wayland`.
- **Packages (i3)**: `i3`, `polybar`, `picom`, `kitty`, `starship`, `rofi`, `feh`, `i3lock`, `xss-lock`, `nm-applet`, `dex`, `maim`, `xclip`, `ckb-next`, and PulseAudio/PipeWire (`pactl`).
- **oh-my-zsh** at `~/.oh-my-zsh` (`.zshrc` sources it; plugins: `git`, `python`, `ssh-agent`).
- **Fonts**: `VictorMono Nerd Font Mono` (kitty), `Roboto Condensed`, `Font Awesome 7` (Free/Solid/Brands), `UbuntuMono Nerd Font` (polybar).
- **Wallpapers**: `~/pictures/wallpapers/wallpaper_big.jpg`, `~/pictures/wallpapers/vertical_wallpaper.jpg`, and `~/pictures/wallpaper.png` (lock screen).
- **Scripts/apps** launched by i3 keybinds: `~/code/scripts/launchwow.sh`, plus `firefox`, `discord`, `spotify-launcher`.

## Machine-specific

- Wifi device (`ip link`): `interface` in `polybar/modules.ini` (`[module/wlan]`) and in `waybar/config.jsonc` (`network`).
- Monitor layout: the `output` lines in `sway/config` (`swaymsg -t get_outputs` lists names and modes) and the `xrandr` line in `i3/config` are hardcoded to specific outputs — edit for your setup. Output names depend on the X driver (`DP-3`/`HDMI-1` under modesetting, `DisplayPort-N`/`HDMI-A-N` under the old amdgpu DDX), so check `xrandr --query` after a driver change.
- Xorg driver: no `xorg.conf` or `xorg.conf.d` driver section is needed. Xorg's built-in `modesetting` driver handles AMD GPUs; don't install `xf86-video-amdgpu` or add a config forcing `Driver "amdgpu"` (the former segfaulted Xorg, and the latter gives "no screens found" without it).
