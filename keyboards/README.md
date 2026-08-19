# Neo75 Cu and Neo65 Cu - shared keymap

Last updated: 2026-08-19

## Design principle

The Neo75 Cu and Neo65 Cu should use the same spatial logic wherever their
physical layouts overlap. The Neo75 may retain convenient dedicated keys, but no
essential function should exist only there.

## Shared base layer

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

On the Neo75, the physical Escape key remains available. On the Neo65, the
top-left key is remapped from Escape to `KC_GRV` so backtick and tilde remain
directly accessible.

### Input-source caveat

`KC_GRV` produces backtick and tilde only under the **ABC** input source, which
is the current selection. **Swedish - Pro** is also enabled on this Mac, and
under it the same physical key produces `§`, with backtick and tilde living on
the dead keys near `´` and `¨`. If the top-left key suddenly stops producing
backtick, check the input source before suspecting the firmware.

## Shared Layer 1

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

## Neo75-specific keys

| Position | Mapping | Status |
| --- | --- | --- |
| Former `RCtrl`, immediately left of Left Arrow | `MO(1)` | Confirmed |
| Top-right extra key, F13 position | `MO(1)` | Confirmed; redundant backup for now |
| Dedicated F-row | F1-F12 | Retained |
| Dedicated Escape | Escape | Retained |

The top-right `MO(1)` can later become Mute or a programmable F13 utility key.
Do not assign an essential function there because the Neo65 has no matching
physical key.

A more useful eventual purpose would be a **left-side** `MO(1)`, since every
current Layer 1 access point is on the right.

## Neo65-specific base layer

| Position | Mapping |
| --- | --- |
| Top-left | `KC_GRV` - backtick/tilde |
| Caps Lock position | Must stay `KC_CAPS` |
| Key immediately left of Left Arrow | `MO(1)` |

The Caps Lock position is a hard constraint. Karabiner matches on the
`caps_lock` key code, so remapping it in VIA silently breaks both tap-Escape and
hold-Hyper.

## Layer structure - open question

VIA exposes four layers on the Neo75 and all four differ. Determine whether
layer 2 is the Windows base layer before using it for anything:

- If layer 2 looks like a near-copy of layer 0 with only the bottom-row
  modifiers reordered (Command/Option swapped for Win/Alt), it is the Windows
  base layer and is spoken for. Every future base-layer change must then be made
  twice, and the Windows-side layer key must be `MO(3)`, not `MO(1)`.
- If layer 2 is unrelated to a base layout, it is genuinely free.

This is no longer blocking, because the connection keycodes moved to Layer 1 and
layers 2 and 3 are not needed for the current design.

## Neo65 Cu tri-mode shortcuts - verify on arrival

Firmware behaviour varies with revision. Verify these on the Neo65 before
overwriting Layer 1, even though the Neo75 confirmed the keycodes are placeable:

| Combination | Reported factory behaviour |
| --- | --- |
| Hold `Fn` + backtick/top-left position | Wired mode |
| Hold `Fn` + `1` / `2` / `3` | Bluetooth profile 1 / 2 / 3 |
| Hold `Fn` + `4` | 2.4 GHz mode |
| `Fn` + Left Command/Win | macOS/Windows mode or Win lock, depending on press duration |
| `Fn` + `D` | Battery status on some Neo65 Cu firmware |
| Hold `Fn` + Delete | Factory reset on some Neo65 Cu firmware |

**Factory reset.** Check whether this is a placeable keycode. If it is, do not
place it anywhere; the physical reset button or holding Escape on plug-in covers
the same need without a keyboard chord that can be hit by accident. If it is
firmware-trapped instead, keep the Layer 1 Delete position free of anything used
in normal work.

Do not factory-reset the board after customisation without first exporting the
VIA layout.

## Navigation keys - arrival-day decision

Match the Neo65 navigation column to the Neo75 wherever possible. Confirm the
physical column and then document the final order for:

- Delete
- Home
- End
- Page Up
- Page Down

Likely layer fallbacks if there are insufficient dedicated positions:

| Combination | Suggested output |
| --- | --- |
| `MO(1)` + Backspace | Delete |
| `MO(1)` + Page Up | Home |
| `MO(1)` + Page Down | End |

Do not finalise these until the actual Neo65 PCB layout is visible in VIA.

## Star21 numpad

Hardware:

- Matte black Star21
- Durock Silent T1 Shrimp switches
- Wireless use intended

Keymap remains to be documented after confirming its configurator and layer
support. Keep ordinary arithmetic keys intact. Num Lock may be repurposed on
macOS if it proves unnecessary, but no essential Neo65 function should depend on
the numpad being present.

## Configuration dependencies

- Keyboard mappings: VIA, stored onboard.
- Neo65 Cu tri-mode configuration: connect by USB and load the correct tri-mode
  JSON.
- Caps tap-Escape / hold-Hyper and double-tap-Right-Shift Caps Lock:
  Karabiner-Elements on macOS, `karabiner/.config/karabiner/karabiner.json` in
  this repo.
- The Karabiner behaviour does not automatically follow the keyboard to Windows,
  iPadOS or another Mac.

### Karabiner device identifiers

Verified by `ioreg` on 2026-08-19:

| Device | Vendor ID | Product ID | Karabiner remapping |
| --- | --- | --- | --- |
| NEO75 | 14000 | 12321 | None; global Caps Lock rule only |
| Keychron (not currently connected) | 13364 | 3409 | Grave ↔ non-US-backslash swap |

The grave/non-US-backslash swap belongs to the Keychron and to no other board.
Neither the Neo75 nor the incoming Neo65 inherits it. Do not copy that device
block for the Neo65 without first confirming the swap is actually wanted there.

### Stow caveat

`karabiner` is listed under `[stow]` in `.dotcore`, but Karabiner-Elements
rewrites its config atomically on every GUI edit, which replaces the stow
symlink with a plain file and silently detaches it from this repo. Copy the live
file into the repo before committing rather than relying on the symlink:

```bash
cp ~/.config/karabiner/karabiner.json ~/.dotfiles/karabiner/.config/karabiner/karabiner.json
```

## Backup checklist

After the Neo65 keymap is final:

1. Export the Neo75 VIA layout into this directory.
2. Export the Neo65 VIA layout into this directory.
3. Sync the live Karabiner config into the repo (see stow caveat), commit, push.
4. Record the installed firmware and JSON versions.
5. Test wired, Bluetooth and 2.4 GHz mode switching.
6. Test charging over the chosen USB-C-to-C cable.
7. Test every Layer 1 binding before daily use.

## Remaining decisions

- Whether layer 2 is the Windows base layer.
- Final Neo65 navigation-column order.
- Final locations for brightness, volume and media controls, and whether the
  media cluster moves to the left half.
- Eventual use of the Neo75 top-right redundant `MO(1)`, likely a left-side
  Layer 1 key instead.
- Star21 numpad mappings.
