# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

These dotfiles target Linux only.

## Deployment

Run `./install.sh` from the repo root. It symlinks each config directory into place (not individual files) and backs up anything already at the target path with a `.bak` suffix. The script aborts on non-Linux systems.

Links created:

- `kitty` → `~/.config/kitty`
- `.zshrc` → `~/.zshrc`
- `i3` → `~/.config/i3`
- `polybar` → `~/.config/polybar`
- `picom` → `~/.config/picom`

## Structure

```
kitty/      # terminal
i3/         # window manager + workspace layouts
polybar/    # status bar
picom/      # compositor
.zshrc      # shell
install.sh
```

## Reload without logging out

- **i3**: `$mod+Shift+c` (reload config) or `$mod+Shift+r` (restart in-place)
- **polybar**: `polybar/i3_bar.sh` — kills existing instances via IPC then relaunches; logs to `/tmp/polybar1.log`
- **picom**: kill and re-run `picom`
- **kitty**: changes apply to new windows immediately

## Architecture

### Color theme

Consistent Everforest/Gruvbox dark palette across all tools, but colors are not centrally sourced — they are duplicated in three places:

- `polybar/colors.ini` — `[gruvbox]` section; referenced as `${gruvbox.NAME}` in `modules.ini` and `config.ini`
- `i3/config` — inline as `$color1`–`$color4`
- `kitty/kitty.conf` — inline hex values

When updating the palette, all three need changing.

### Polybar split config

`polybar/config.ini` is the entry point, including:
- `colors.ini` — palette
- `modules.ini` — all widget definitions (rofi launcher, i3 workspaces, xwindow title, pulseaudio, clock, power menu)

### i3 startup chain

i3 auto-starts the rest of the stack via `exec_always`:
1. `feh` sets the wallpaper from `~/pictures/wallpaper.jpg`
2. `~/.config/polybar/i3_bar.sh` launches the bar
3. `picom` starts the compositor

`xss-lock` and `nm-applet` run via `exec` (once only, not on reload).

### Key layout conventions

**i3 — modifier: Super (Mod4)**
- Focus/move: `hjkl`
- Gap adjustment: `$mod+s`/`$mod+Shift+s` (inner), `$mod+z`/`$mod+Shift+z` (outer)
- Reset gaps: `$mod+Shift+t`
- Split toggle: `$mod+t`
