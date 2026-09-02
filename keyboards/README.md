# Keyboards

Last updated: 2026-09-02

Single source of truth for the physical keyboards, their VIA definitions and
keymaps, and the Karabiner rules that sit on top of them. Nothing about
keyboard hardware or keymaps should live in the repo root README; that file
links here.

## The boards

| Board | Layout | Directory | VIA definition |
| --- | --- | --- | --- |
| QwertyKeys Neo75 CU | ANSI | `neo75/` | `neo75-via-definition.json`, V2 |
| QwertyKeys Neo65 CU | ANSI | `neo65/` | not yet obtained |
| Weikav Stars21 numpad | 21-key numpad | `stars21/` | `s21-via-definition.json`, V3 |
| Keychron (older, not in daily use) | unconfirmed | not documented | n/a |

All three are VIA boards, and none of them is in VIA's remote definition
database. Every one needs its JSON sideloaded through the Design tab. Keep the
JSONs in this repo; vendor download links rot.

**V2 versus V3 matters.** The Neo75 definition is a V2 file, so VIA needs
Settings, "Use V2 definitions" turned on to load it. The Stars21 definition is
V3 and needs that toggle off. If you configure both in one browser you will be
flipping it. Each board's own README records which format it is.

## Design principle

The Neo75 and Neo65 should use the same spatial logic wherever their physical
layouts overlap. The Neo75 may retain convenient dedicated keys, but no
essential function should exist only there.

The Stars21 is not part of that contract. It is a right-hand-alone device and
its keymap serves numeric entry, not the main board.

**Layers do not cross devices.** Each keyboard is its own USB HID device with
its own firmware and its own layer state. Holding `MO(1)` on the numpad changes
what the numpad's keys send and nothing else. Anything that needs to work "on
the other board" has to exist on that board, or go through Karabiner.

## Shared base layer, Neo75 and Neo65

### Bottom row

| Physical position | VIA keycode | macOS meaning | Power 2048 legend |
| --- | --- | --- | --- |
| Far left | `LCtrl` | Left Control | `⌃` |
| Second from left | `LAlt` | Left Option | `⌥` |
| Third from left | `LWin` / `LGUI` | Left Command | `⌘` |
| Spacebar | `Space` | Space | blank |
| First right of Space | `RWin` / `RGUI` | Right Command | `⌘` |
| Immediately left of Left Arrow | `MO(1)` | Hold for Layer 1 | `≡` |

`RCtrl` has been removed because it was not used. Its physical position is now
the permanent Layer 1 key on both keyboards.

### Escape, Hyper and backtick

| Input | Output |
| --- | --- |
| Tap Caps Lock | Escape |
| Hold Caps Lock with another key | Hyper: Shift + Control + Option + Command |
| Double-tap Right Shift | Real Caps Lock toggle |
| Top-left number-row key | Backtick; Shift produces tilde |
| `MO(1)` + top-left backtick key | Escape |

The Caps Lock dual-role behaviour is short tap for Escape, long hold for Hyper.
This is provided by Karabiner-Elements, not by the keyboard, so it works on the
configured Mac and not automatically on every device. `MO(1)` + backtick is the
keyboard-side Escape fallback, and it survives recovery mode, a fresh macOS
install, or any machine without Karabiner.

Tap-Escape fires on key release rather than key press, and will not repeat when
held. Karabiner's default alone-timeout is 1000 ms, so a Caps Lock press held
longer than one second and released without another key produces nothing. This
is not noticeable at normal typing speed.

## Shared Layer 1, Neo75 and Neo65

### Escape

| Combination | Output |
| --- | --- |
| `MO(1)` + backtick/tilde position | Escape |

### Function row

| Combination | Output |
| --- | --- |
| `MO(1)` + `1` … `0` | F1 … F10 |
| `MO(1)` + `-` | F11 |
| `MO(1)` + `=` | F12 |

The Stars21 carries its own F1 to F12 block on its layer 1, so the F row is
reachable from the numpad regardless of which main board is connected. See
`stars21/README.md`.

### Connection control

The wireless keycodes are exposed in VIA as ordinary placeable keycodes
(`USB`, `BLE1`, `BLE2`, `BLE3`), confirmed on the Neo75. They are not trapped in
firmware, so the factory `Fn + 1/2/3/4` placement is only a default and can be
moved freely. Relocating them to the `QWERT` row removes the collision with
F1-F4 entirely.

| Combination | Output |
| --- | --- |
| `MO(1)` + `Q` | `USB` |
| `MO(1)` + `W` | `BLE1` |
| `MO(1)` + `E` | `BLE2` |
| `MO(1)` + `R` | `BLE3` |
| `MO(1)` + `T` | 2.4 GHz |

Bound on both boards, so the connection block reads `USB, 1, 2, 3, 2.4` from
left to right and the two keymaps stay spatially identical. Harmless on the
Neo75 even if it never uses the dongle: an unused connection keycode does
nothing rather than misfiring.

All five sit on the left hand, so nothing competes with the right-side `MO(1)`.

### Media and system

| Combination | Output |
| --- | --- |
| `MO(1)` + Left / Right | Screen brightness down / up |
| `MO(1)` + Down / Up | Volume down / up |
| `MO(1)` + `M` | Mute |
| `MO(1)` + `J` / `K` / `L` | Previous / Play-Pause / Next |

Note: `M` and `J`/`K`/`L` are right-hand keys and `MO(1)` is a right-side key,
so these are same-hand chords. Consider moving them to the left half
(`Z`/`X`/`C`, `A`/`S`/`D`) if they prove awkward in daily use. The arrow
bindings are fine, since `MO(1)` sits directly beside the arrow cluster.

Unused Layer 1 positions should normally be `KC_TRNS`, not `KC_NO`, so their
base-layer behaviour passes through.

## Legends versus what the key actually sends

Three things can disagree, and all three have bitten before:

1. **The physical layout.** Both Neo boards are ANSI: one-row Enter, full-width
   left Shift, no extra key left of `Z`. The Neo75 definition still offers ISO
   Enter and split-shift options, so VIA's Layouts section has to be set to the
   ANSI build or the rendered board is wrong and you will edit the wrong key.
2. **The keycap legend.** The Power 2048 set is legended for a US/ANSI mental
   model, which matches the boards, so caps and keycodes agree by default. They
   part ways wherever a key has been remapped in VIA, most of all on the bottom
   row and the former `RCtrl` position, now `MO(1)`.
3. **The macOS input source.** `KC_GRV` produces backtick and tilde only under
   **ABC**, which is the current selection. **Swedish - Pro** is also enabled on
   this Mac, and under it the same physical key produces `§`, with backtick and
   tilde living on the dead keys near `´` and `¨`.

If a key suddenly stops producing what its cap says, check the input source
first, the VIA layout option second, and only then suspect the firmware.

## Karabiner

Profile in use: **NeoCode**.

Global rules, applied to every keyboard:

- **Caps Lock** hold, Hyper (Control + Shift + Option + Command), used for app
  launching and global shortcuts through Raycast
- **Caps Lock** tap, Escape
- **Double-tap Right Shift**, real Caps Lock toggle

Per-device rules, verified by `ioreg` on 2026-08-19 and re-checked 2026-09-02:

| Device | Vendor ID | Product ID | Karabiner remapping |
| --- | --- | --- | --- |
| NEO75 | 14000 (`0x36B0`) | 12321 (`0x3021`) | None; global Caps Lock rules only |
| NEO (second entry) | 14000 (`0x36B0`) | 12292 (`0x3004`) | None; likely the same board on another connection mode |
| Keychron (not currently connected) | 13364 (`0x3434`) | 3409 (`0x0D51`) | Grave ↔ non-US-backslash swap, an ANSI layout fix |
| Weikav Stars21 | 13357 (`0x342D`) | 58691 (`0xE543`) | None; no device block yet |

The grave/non-US-backslash swap belongs to the Keychron and to no other board.
Neither the Neo75 nor the incoming Neo65 inherits it. Do not copy that device
block for the Neo65 without first confirming the swap is actually wanted there.

Caps Lock on the Neo65 must stay `KC_CAPS` in VIA. Karabiner matches on the
`caps_lock` key code, so remapping it in firmware silently breaks both
tap-Escape and hold-Hyper.

### Stow caveat

`karabiner` is listed under `[stow]` in `.dotcore`, but Karabiner-Elements
rewrites its config atomically on every GUI edit, which replaces the stow
symlink with a plain file and silently detaches it from this repo. Copy the live
file into the repo before committing rather than relying on the symlink:

```bash
cp ~/.config/karabiner/karabiner.json ~/.dotfiles/karabiner/.config/karabiner/karabiner.json
```

## Configuration dependencies

- Keyboard mappings: VIA, stored onboard, so they follow the board to any
  machine.
- Every board needs its VIA JSON sideloaded through the Design tab first. VIA
  keeps sideloaded drafts in browser local storage, so clearing site data for
  usevia.app means loading them again. That is why the JSONs live here.
- Caps tap-Escape, hold-Hyper, and double-tap-Right-Shift Caps Lock:
  Karabiner-Elements on macOS, `karabiner/.config/karabiner/karabiner.json` in
  this repo.
- The Karabiner behaviour does not automatically follow a keyboard to Windows,
  iPadOS or another Mac. Anything essential belongs in firmware instead.

## Backup checklist

After a keymap is final:

1. Export the VIA layout into that board's directory.
2. Sync the live Karabiner config into the repo (see stow caveat), commit, push.
3. Record the installed firmware and JSON versions in the board's README.
4. Test wired, Bluetooth and 2.4 GHz mode switching.
5. Test charging over the chosen USB-C-to-C cable.
6. Test every Layer 1 binding before daily use.

## Open cross-board decisions

- Final locations for brightness, volume and media controls, and whether the
  media cluster moves to the left half on both boards.
- Whether the Stars21 gets a Karabiner device block at all, or stays
  firmware-only.

Board-specific open questions live in each board's own README.
