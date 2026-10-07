# simple

A fork of [foot](https://codeberg.org/dnkl/foot) — the fast, lightweight,
Wayland-native terminal emulator — renamed to `simple`.

Nothing about foot's behaviour has been changed. This is foot with a
different name, so it can be installed and run alongside it.

![sixel](doc/sixel-wow.png "Sixel graphics support")


## What's different

| | upstream foot | simple |
|---|---|---|
| binaries | `foot`, `footclient` | `simple`, `simpleclient` |
| config | `~/.config/foot/foot.ini` | `~/.config/simple/simple.ini` |
| socket | `$XDG_RUNTIME_DIR/foot-$WAYLAND_DISPLAY.sock` | `.../simple-$WAYLAND_DISPLAY.sock` |
| `TERM` | `foot` | `simple` |
| terminfo | `foot`, `foot-direct` | `simple`, `simple-direct` |

The install paths move too: terminfo lands in `share/terminfo/s/`, themes
in `share/simple/themes/`, docs in `share/doc/simple/`.

Full list of renames is in the commit message of
[`6b12f2b9`](https://github.com/noxthedevwindev-greatest/simple/commit/6b12f2b9).

### One caveat

`TERM` now defaults to `simple`, so a **remote host that doesn't have this
build installed has no `simple` terminfo entry** — curses apps and anything
else reading `TERM` will misbehave over ssh. If that bites you, build with
`-Ddefault-terminfo=foot`, or copy `simple` and `simple-direct` into
`~/.terminfo/s/` on the remote box.


## Features

* Fast, lightweight, Wayland native
* Server/daemon mode (`simple --server` + `simpleclient`)
* Scrollback search, keyboard-driven URL detection
* User configurable font fallback, on-the-fly resize and DPI adjustment
* Color emoji, IME via `text-input-v3`, multi-seat
* True Color, styled underlines, synchronized updates, Sixel graphics


## Building

Requires meson, a C11 compiler, and the dev packages for wayland-client,
wayland-cursor, wayland-protocols, xkbcommon, freetype, fontconfig and
pixman. `tllist`, `fcft` and utf8proc are pulled in automatically as
subprojects if they're not installed system-wide.

```sh
meson setup bld
ninja -C bld
sudo ninja -C bld install
```

Packaging notes and the full list of build options are in
[INSTALL.md](INSTALL.md).


## Configuration

`~/.config/simple/simple.ini` — a commented example ships at
[`simple.ini`](simple.ini) in this repo and installs to
`/etc/xdg/simple/simple.ini`.

```ini
[main]
font=monospace:size=10
term=simple
```

See [`simple.ini(5)`](doc/simple.ini.5.scd) for every option.


## Documentation

* [`simple(1)`](doc/simple.1.scd) — general, key bindings, shell integration
* [`simple.ini(5)`](doc/simple.ini.5.scd) — configuration reference
* [`simpleclient(1)`](doc/simpleclient.1.scd) — client and server mode
* [`simple-ctlseqs(7)`](doc/simple-ctlseqs.7.scd) — supported escape sequences


## Pulling in upstream changes

```
git remote -v
origin    https://github.com/noxthedevwindev-greatest/simple.git
upstream  https://github.com/yonasBSD/foot
```

```sh
git fetch upstream
git log -p upstream/main -1        # read what changed first
```

Merging will conflict on almost every renamed file, since the rename
touched 72 of them. There's no clean way around that; cherry-pick
individual upstream commits by hand when possible.

---

*simple is a fork of [foot](https://codeberg.org/dnkl/foot) by Daniel
Eklöf, MIT licensed. See [LICENSE](LICENSE) and
[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md). Upstream issues:
<https://codeberg.org/dnkl/foot/issues>.*
