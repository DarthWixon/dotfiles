# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

These dotfiles target Linux only.

## Git

Commit and push straight to `main`; no feature branches or pull requests. This overrides the "branch before committing on the default branch" rule in the personal `claude/CLAUDE.md`. Committing and pushing still happen only when asked.

## Deployment

Run `./install.sh` from the repo root. It symlinks each config directory into place (not individual files) and backs up anything already at the target path with a `.bak` suffix. The script aborts on non-Linux systems.

Links created:

- `kitty` → `~/.config/kitty`
- `.zshrc` → `~/.zshrc`
- `i3` → `~/.config/i3`
- `sway` → `~/.config/sway`
- `waybar` → `~/.config/waybar`
- `polybar` → `~/.config/polybar`
- `picom` → `~/.config/picom`
- `colors` → `~/.config/colors`
- `starship/starship.toml` → `~/.config/starship.toml` (single file, not a directory)
- `claude/CLAUDE.md` → `~/.claude/CLAUDE.md` (single file; never link the whole `~/.claude`, it holds credentials and session data)

## Structure

```
kitty/      # terminal
i3/         # X window manager (fallback session until sway has proved itself)
sway/       # Wayland window manager (main session)
waybar/     # sway status bar
polybar/    # i3 status bar
picom/      # i3 compositor
starship/   # shell prompt
colors/     # shared palette + build.sh template renderer
claude/     # personal Claude Code CLAUDE.md
.zshrc      # shell
install.sh
```

## Reload without logging out

- **i3**: `$mod+Shift+c` (reload config) or `$mod+Shift+r` (restart in-place)
- **sway**: `$mod+Shift+c` (reload config; also restarts waybar). Sway has no in-place restart
- **polybar**: `polybar/i3_bar.sh` — kills existing instances via IPC then relaunches; logs to `/tmp/polybar1.log`
- **picom**: kill and re-run `picom`
- **kitty**: changes apply to new windows immediately

## Architecture

### Color theme

Everforest Dark (medium). `colors/everforest.ini` (`[palette]` section, official Everforest names like `bg0`, `fg`, `green`, `grey1`) is the single source of truth, linked to `~/.config/colors/everforest.ini`.

How each program gets its colours:

- **polybar** — `config.ini` includes the palette directly; `colors.ini` maps polybar's own names (`${everforest.black}` etc.) onto `${palette.NAME}`
- **waybar** — `waybar/style.css.tmpl` renders to `waybar/style.css`
- **i3** and **sway** — `i3/theme.conf.tmpl` and `sway/theme.conf.tmpl` uses `{{name}}` placeholders; `colors/build.sh` renders each to `theme.conf` (gitignored), which that window manager's `config` includes. i3 can't use variables set in an included file, so templating is required
- **kitty** — `kitty/everforest-dark-medium.conf.tmpl` renders to the theme file that `kitty.conf` includes
- **starship** — the whole config is `starship/starship.toml.tmpl`; edit the template (prompt layout included), not the rendered `starship.toml`

To add a program: write `<file>.tmpl` with `{{name}}` placeholders and add the rendered file to `.gitignore`. `build.sh` renders every `*.tmpl` in the repo and fails on unknown names. `install.sh` runs it before linking.

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

### Sway

Replaces i3 because the modesetting Xorg driver tears on the rotated monitor; sway rotates on the GPU (`transform 90`). Output names differ from X: `DP-3` and `HDMI-A-1`. It starts swaybg (wallpaper), waybar (via `bar { swaybar_command waybar }`), swayidle (locks with swaylock after 10 minutes and before sleep) and ckb-next. Waybar has no tray module on purpose, so no app tray icons (Discord, nm-applet, etc.) are shown; nm-applet isn't started since the network module covers wifi. `~/dotfiles/lockscreen.sh` is i3-only; sway's lock command is `$lock` in `sway/config`.

### Key layout conventions

**i3 and sway — modifier: Super (Mod4)**
- Focus/move: `hjkl`
- Gap adjustment: `$mod+s`/`$mod+Shift+s` (inner), `$mod+z`/`$mod+Shift+z` (outer)
- Reset gaps: `$mod+Shift+t`
- Split toggle: `$mod+t`
