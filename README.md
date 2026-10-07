# self

A fork of [foot](https://codeberg.org/dnkl/foot) — the fast, lightweight,
Wayland-native terminal emulator — renamed to `self`.

Nothing about foot's behaviour has been changed. This is foot with a
different name, so it can be installed and run alongside it.

![sixel](doc/sixel-wow.png "Sixel graphics support")


## What's different

| | upstream foot | self |
|---|---|---|
| binaries | `foot`, `footclient` | `self`, `selfc` |
| config | `~/.config/foot/foot.ini` | `~/.config/self/self.ini` || socket | `$XDG_RUNTIME_DIR/foot-$WAYLAND_DISPLAY.sock` | `.../self-$WAYLAND_DISPLAY.sock` |
| `TERM` | `foot` | `self` |
| terminfo | `foot`, `foot-direct` | `self`, `self-direct` |

The install paths move too: terminfo lands in `share/terminfo/s/`, themes
in `share/self/themes/`, docs in `share/doc/self/`.

Upstream rename commits: [`6b12f2b9`](https://github.com/noxthedevwindev-greatest/self/commit/6b12f2b9)
(foot → simple) and the current one (simple → self).


## Features

* Fast, lightweight, Wayland native
* Server/daemon mode (`self --server` + `selfc`)
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

`~/.config/self/self.ini` — a commented example ships at
[`self.ini`](self.ini) in this repo and installs to
`/etc/xdg/self/self.ini`.

```ini
[main]
font=monospace:size=10
term=self
```

See [`self.ini(5)`](doc/self.ini.5.scd) for every option.


## Documentation

* [`self(1)`](doc/self.1.scd) — general, key bindings, shell integration
* [`self.ini(5)`](doc/self.ini.5.scd) — configuration reference
* [`selfc(1)`](doc/selfc.1.scd) — client and server mode
* [`self-ctlseqs(7)`](doc/self-ctlseqs.7.scd) — supported escape sequences


## Pulling in upstream changes

```
git remote -v
origin    https://github.com/noxthedevwindev-greatest/self.git
upstream  https://github.com/yonasBSD/foot
```

```sh
git fetch upstream
git log -p upstream/main -1        # read what changed first
```

Merging will conflict on almost every renamed file, since the rename
touched 72 of them. There's no clean way around that; cherry-pick
individual upstream commits by hand when possible.


## Plans

Currently just foot under a new name. Features will land here as they're
added — open an issue or a PR.


---

*self is a fork of [foot](https://codeberg.org/dnkl/foot) by Daniel
Eklöf, MIT licensed. See [LICENSE](LICENSE) and
[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md). Upstream issues:
<https://codeberg.org/dnkl/foot/issues>.*
