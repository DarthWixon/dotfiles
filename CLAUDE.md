# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Deployment

Run `./install.sh` from the repo root. It detects the OS and links the right configs:

- **Linux** — links everything under `shared/` and `linux/`
- **macOS personal** — links `shared/` and `macos/personal/`; set `DOTFILES_PROFILE=personal` or answer the prompt
- **macOS work** — links `shared/` only; set `DOTFILES_PROFILE=work`

The script symlinks directories (not individual files), backs up anything already at the target path with a `.bak` suffix, and sets `yabairc` executable.

## Structure

```
shared/          # kitty, zsh — all machines
linux/           # i3, polybar, picom
macos/
  personal/      # yabai, skhd
install.sh
```

## Reload without logging out

- **i3**: `$mod+Shift+c` (reload config) or `$mod+Shift+r` (restart in-place)
- **polybar**: `linux/polybar/i3_bar.sh` — kills existing instances via IPC then relaunches; logs to `/tmp/polybar1.log`
- **picom**: kill and re-run `picom`
- **kitty**: changes apply to new windows immediately
- **yabai**: `yabai --restart-service` or kill and relaunch; the `dock_did_restart` signal in `yabairc` reloads the scripting addition automatically
- **skhd**: `skhd --restart-service`

## Architecture

### Color theme

Consistent Everforest/Gruvbox dark palette across all tools, but colors are not centrally sourced — they are duplicated in three places:

- `linux/polybar/colors.ini` — `[gruvbox]` section; referenced as `${gruvbox.NAME}` in `modules.ini` and `config.ini`
- `linux/i3/config` — inline as `$color1`–`$color4`
- `shared/kitty/kitty.conf` — inline hex values
- `macos/personal/yabai/yabairc` — border colours as 0xffRRGGBB hex

When updating the palette, all four need changing.

### Polybar split config

`linux/polybar/config.ini` is the entry point, including:
- `colors.ini` — palette
- `modules.ini` — all widget definitions (rofi launcher, i3 workspaces, xwindow title, pulseaudio, clock, power menu)

### i3 startup chain

i3 auto-starts the rest of the Linux stack via `exec_always`:
1. `feh` sets the wallpaper from `~/pictures/wallpaper.jpg`
2. `~/.config/polybar/i3_bar.sh` launches the bar
3. `picom` starts the compositor

`xss-lock` and `nm-applet` run via `exec` (once only, not on reload).

### Key layout conventions

**Linux (i3) — modifier: Super (Mod4)**
- Focus/move: `hjkl`
- Gap adjustment: `$mod+s`/`$mod+Shift+s` (inner), `$mod+z`/`$mod+Shift+z` (outer)
- Reset gaps: `$mod+Shift+t`
- Split toggle: `$mod+t`

**macOS personal (yabai + skhd) — modifier: Option (alt)**
- Focus/swap: `alt+hjkl` / `shift+alt+hjkl`
- Space focus: `alt+1`–`alt+9`
- Move window to space: `shift+alt+1`–`shift+alt+9`
- Gap adjustment: `alt+s` / `shift+alt+s`
- Float toggle: `alt+space`
- Fullscreen: `alt+f`

### yabai scripting addition

`yabairc` calls `sudo yabai --load-sa` on startup and reloads it automatically when Dock restarts via the `dock_did_restart` signal. This requires partial SIP disable and passwordless sudo configured for `/usr/local/bin/yabai`. Without it, multi-space window management won't work.

## macOS personal setup checklist

One-time steps for a fresh machine. Do them in order.

**1. Install tools**
- [ ] `brew install koekeishiya/formulae/yabai`
- [ ] `brew install koekeishiya/formulae/skhd`

**2. Partially disable SIP** *(requires a reboot — skip if already done)*
- [ ] Shut down, then boot into Recovery Mode (hold the power button on Apple Silicon; hold Cmd+R on Intel)
- [ ] Open Terminal from the Utilities menu
- [ ] Apple Silicon: `csrutil enable --without debug --without fs --without nvram`
- [ ] Intel: `csrutil enable --without debug --without fs`
- [ ] Reboot

**3. Install the scripting addition**
- [ ] `sudo yabai --install-sa`

**4. Configure passwordless sudo for the scripting addition**

Get the sha256 hash of your yabai binary:
```sh
shasum -a 256 $(which yabai)
```
Add a line to sudoers via `sudo visudo -f /private/etc/sudoers.d/yabai`:
```
<your-username> ALL=(root) NOPASSWD: sha256:<hash-from-above> <path-from-above> --load-sa
```
Example:
```
will ALL=(root) NOPASSWD: sha256:abc123... /opt/homebrew/bin/yabai --load-sa
```
This needs re-doing after every yabai update (the hash changes).

**5. Grant permissions**
- [ ] System Settings → Privacy & Security → Accessibility → add and enable `yabai`
- [ ] System Settings → Privacy & Security → Accessibility → add and enable `skhd`

**6. Deploy dotfiles**
- [ ] `DOTFILES_PROFILE=personal ./install.sh`

**7. Start services**
- [ ] `yabai --start-service`
- [ ] `skhd --start-service`

**Verify:** open a few windows — they should tile automatically. `alt+h/j/k/l` should move focus between them.
