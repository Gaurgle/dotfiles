# QwertyKeys Neo65 CU

Last updated: 2026-09-02

Not yet in hand. See `../README.md` for the shared base layer and Layer 1 this
board must implement, and `../neo75/README.md` for the board it mirrors.

## VIA definition

Not yet obtained. Get it from the vendor before the board arrives and commit it
here. Expect the same V2 format as the Neo75, and expect VIA's remote database
not to have it.

Confirm the physical layout when ordering or on arrival. The Neo75 is ISO
Nordic; if the Neo65 differs, the VIA Layouts options and the keycap legends
diverge from the Neo75 and the shared keymap needs re-checking key by key.

## Base layer, board-specific

| Position | Mapping |
| --- | --- |
| Top-left | `KC_GRV`, backtick and tilde |
| Caps Lock position | Must stay `KC_CAPS` |
| Key immediately left of Left Arrow | `MO(1)` |

The board has no dedicated Escape, so the top-left key is remapped from Escape
to `KC_GRV` and Escape comes from Caps Lock tap, with `MO(1)` + backtick as the
Karabiner-free fallback.

The Caps Lock position is a hard constraint. Karabiner matches on the
`caps_lock` key code, so remapping it in VIA silently breaks both tap-Escape and
hold-Hyper.

## Tri-mode shortcuts, verify on arrival

Firmware behaviour varies with revision. Verify these before overwriting Layer
1, even though the Neo75 confirmed the connection keycodes are placeable:

| Combination | Reported factory behaviour |
| --- | --- |
| Hold `Fn` + backtick/top-left position | Wired mode |
| Hold `Fn` + `1` / `2` / `3` | Bluetooth profile 1 / 2 / 3 |
| Hold `Fn` + `4` | 2.4 GHz mode |
| `Fn` + Left Command/Win | macOS/Windows mode or Win lock, depending on press duration |
| `Fn` + `D` | Battery status on some Neo65 CU firmware |
| Hold `Fn` + Delete | Factory reset on some Neo65 CU firmware |

**Factory reset.** Check whether this is a placeable keycode. If it is, do not
place it anywhere; the physical reset button or holding Escape on plug-in covers
the same need without a keyboard chord that can be hit by accident. If it is
firmware-trapped instead, keep the Layer 1 Delete position free of anything used
in normal work.

Do not factory-reset the board after customisation without first exporting the
VIA layout.

## Navigation keys, arrival-day decision

Match the navigation column to the Neo75 wherever possible. Confirm the physical
column and then document the final order for Delete, Home, End, Page Up, Page
Down.

Likely layer fallbacks if there are insufficient dedicated positions:

| Combination | Suggested output |
| --- | --- |
| `MO(1)` + Backspace | Delete |
| `MO(1)` + Page Up | Home |
| `MO(1)` + Page Down | End |

`MO(1)` + Backspace for forward Delete is the intended home for that key. It was
considered for the Stars21 top row and rejected: forward-delete is pressed
mid-typing with both hands on the main board, so putting it on the numpad is a
hand move for nothing.

Do not finalise these until the actual PCB layout is visible in VIA.

## Open questions

- Physical layout, ISO Nordic or otherwise.
- Whether layer 2 is the Windows base layer, same question as the Neo75.
- Final navigation-column order.
