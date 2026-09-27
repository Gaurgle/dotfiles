# Keyboards

Last updated: 2026-09-27

Single source of truth for the physical keyboards, their VIA definitions and
keymaps, and the Karabiner rules that sit on top of them. Nothing about
keyboard hardware or keymaps should live in the repo root README; that file
links here.

## The boards

| Board | Layout | Directory | VIA definition |
| --- | --- | --- | --- |
| QwertyKeys Neo75 CU | ANSI | `neo75/` | `neo75-via-definition.json`, V2 |
| QwertyKeys Neo65 CU | ANSI, split Backspace | `neo65/` | `neo65cu-via-definition.json`, V3 |
| Weikav Stars21 numpad | 21-key numpad | `stars21/` | `s21-via-definition.json`, V3 |
| Keychron (older, not in daily use) | unconfirmed | not documented | n/a |

All three are VIA boards, and none of them is in VIA's remote definition
database. Every one needs its JSON sideloaded through the Design tab. Keep the
JSONs in this repo; vendor download links rot.

**V2 versus V3 matters.** The Neo75 definition is a V2 file, so VIA needs
Settings, "Use V2 definitions" turned on to load it. The Neo65 and Stars21
definitions are V3 and need that toggle off. If you configure both in one browser you will be
flipping it. Each board's own README records which format it is.

## Design principle

The Neo75 and Neo65 should use the same spatial logic wherever their physical
layouts overlap. The Neo75 may retain convenient dedicated keys, but no
essential function should exist only there.

The Stars21 is not part of that contract. It is a right-hand-alone device and
its keymap serves numeric entry, not the main board. **No essential function may
depend on the numpad being connected**, for the same reason nothing essential
may live only on the Neo75.

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

Both boards have exactly two keys between Space and Left Arrow, confirmed on the
Neo75 and the Neo65 build, so the right side reads `Space, RWin, MO(1), ←`.
There is no third right-side modifier.

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

**Where the two boards differ.** The Neo75 keeps its physical Escape key, so
its top-left number-row key is an ordinary backtick. The Neo65 has no dedicated
Escape, so its top-left key is remapped from Escape to `KC_GRV` to keep backtick
and tilde directly accessible, and Escape comes from Caps Lock tap with
`MO(1)` + backtick as the fallback. Same legend, same position, different
factory keycode.

Tap-Escape fires on key release rather than key press, and will not repeat when
held. Karabiner's default alone-timeout is 1000 ms, so a Caps Lock press held
longer than one second and released without another key produces nothing. This
is not noticeable at normal typing speed.

## Shared layers 1 and 3, Neo75 and Neo65

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

The wireless keycodes are ordinary placeable VIA keycodes (`MD_USB`,
`MD_BLE1`-`3`, `MD_24G`), confirmed on both boards. Both use the Neo65 CU
factory placement, so Qwertykeys' docs and support apply as written:

| Combination | Output |
| --- | --- |
| `MO(1)` + Tab | USB |
| `MO(1)` + `Q` / `W` / `E` | Bluetooth 1 / 2 / 3 (hold 3 s to re-pair) |
| `MO(1)` + `R` | 2.4 GHz |

All on the left hand, so nothing competes with the right-side `MO(1)`. Harmless
on the Neo75 even if it never uses the dongle.

### Media layer, layer 3

Media keys live on their own layer, reached by holding Fn and then the **first
key right of Space** (`MO(3)` on layer 1), both with the right thumb. Layer 3
carries media on the number row plus `MD_USB` on Tab as a second way back to
wired. The earlier media chords on the arrows, `M` and `J`/`K`/`L` were dropped.

This relies on the Qwertykeys layer scheme: layers 0/1 are the Windows base and
Fn layers, 2/3 the Mac ones, and the boards must run in **Windows mode** so both
layer 1 and layer 3 sit above the base. Media must never sit on layer 2, which
is the Mac-mode base. Layer 2 is a copy of layer 0 whose Fn key is `MO(3)`,
never `MO(1)`. See `neo65/README.md` for the full table, why `MO(1)` fails from
layer 2, and the open Mac-mode problem on the Neo65.

Unused Fn-layer positions should normally be `KC_TRNS`, not `KC_NO`, so their
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

- Port the Neo65 target keymap to the Neo75 once the Neo65 is confirmed in
  Windows mode. The Neo75's layer scheme (Windows 0/1, Mac 2/3) is assumed from
  the Neo65 and still needs checking in VIA.
- Whether the Stars21 gets a Karabiner device block at all, or stays
  firmware-only.

Board-specific open questions live in each board's own README.
