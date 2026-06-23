# Molok Top Window List

A GNOME Shell extension that displays a window list and workspace indicator
in the top panel.

## Features

- **Window list** — shows all open windows in the top panel
- **App grouping** — group windows by application (never, auto, or always)
- **Drag and drop** — reorder windows directly from the panel
- **Workspace indicator** — shows workspace previews embedded in the window list
- **Multi-workspace** — optionally show windows from all workspaces
- **Multi-monitor** — show the window list on all monitors or only the primary one
- **Light and dark themes** — stylesheets for both variants

## Requirements

- GNOME Shell 50
- GJS
- GLib (with GSettings support)

## Build

Ensure `glib-compile-schemas` is available, then run:

```sh
./build.sh
```

This compiles the GSettings schema and runs a syntax check on the JavaScript files.

## Install

### User install (recommended)

```sh
./install.sh
```

This copies the extension into `~/.local/share/gnome-shell/extensions/`.

### System-wide install

```sh
sudo ./install.sh /usr/share/gnome-shell/extensions/top-window-list.molok.github.io
```

### Enable the extension

After installation, restart GNOME Shell and enable the extension:

```sh
# Restart GNOME Shell:
#   Wayland: log out and log back in
#   X11:     Alt+F2 → r → Enter
#
# Then enable:
gnome-extensions enable top-window-list.molok.github.io
```

### Meson install

```sh
meson setup _build
meson install -C _build
```

## Keybindings

| Action | Default | Description |
|---|---|---|
| Switch to window on the left | `<Super>h` | Focus the previous window in the list |
| Switch to window on the right | `<Super>l` | Focus the next window in the list |

> **⚠ Conflict note:** `<Super>h` and `<Super>l` clash with two built-in GNOME
> Shell shortcuts: **Hide window** and **Lock screen**. To use them for window
> switching, unbind the defaults first:
>
> ```sh
> # Free up Super+H (Hide window → disabled)
> gsettings set org.gnome.desktop.wm.keybindings minimize "[]"
>
> # Free up Super+L (Lock screen → disabled)
> gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "[]"
> ```
>
> A GNOME Shell restart is required after changing these (log out / log back in
> on Wayland, or Alt+F2 → `r` → Enter on X11).
>
> You can change the extension's keybindings to any combination you prefer:
>
> ```sh
> gsettings set org.gnome.shell.extensions.top-window-list.molok.github.io switch-to-window-left "['<Super>h']"
> gsettings set org.gnome.shell.extensions.top-window-list.molok.github.io switch-to-window-right "['<Super>l']"
> ```
>
> After changing keybindings, disable and re-enable the extension:
>
> ```sh
> gnome-extensions disable top-window-list.molok.github.io
> gnome-extensions enable top-window-list.molok.github.io
> ```

## Preferences

The extension provides the following settings via `gnome-extensions prefs`
or the Extensions app:

| Setting | Default | Description |
|---|---|---|
| Grouping mode | `never` | When to group windows of the same app |
| Display all workspaces | `false` | Show windows from all workspaces |
| Show on all monitors | `false` | Show the window list on every monitor |
| Embed previews | `true` | Show workspace previews in the window list |

## License

GPL-2.0-or-later
