# Weikav Stars21 numpad

Last updated: 2026-09-02

Assembled 2026-09-02. See `../README.md` for the Karabiner rules and the
cross-board conventions. This board is deliberately **not** part of the
Neo75/Neo65 shared keymap contract: it is a right-hand-alone device and its
keymap serves numeric entry.

## Hardware

- Matte black Weikav Stars21, 21 keys
- Durock Silent T1 Shrimp switches
- Wireless use intended

## VIA definition

`s21-via-definition.json` is Weikav's own definition, verified against the
connected board:

| Field | Value |
| --- | --- |
| Name | `S21` |
| Vendor ID | `0x342D` (13357) |
| Product ID | `0xE543` (58691) |
| Matrix | 6 rows x 4 cols |
| Format | **VIA V3** (`menus` + `keycodes`), so the V2 toggle must be **off** |

Source: the "Stars21-S" VIA JSON linked from https://weikav.com/waikv-software/
downloaded 2026-09-02.

The board is sold as VIA compatible, which only means the firmware speaks the
VIA protocol. Weikav never submitted the definition to `the-via/keyboards`, so
VIA's remote database has nothing for `0x342D:0xE543` and fails with "VIA could
not find a V3 definition for S21". The board itself is fine. Load the JSON in
Chrome or Edge (Safari and Firefox have no WebHID) via the Design tab, with
**Show Design tab** enabled in Settings.

Program it while wired. VIA talks over USB HID only, so in Bluetooth or 2.4 GHz
mode the browser will not see the board.

## Physical layout

A standard 17-key numpad with a bonus 4-key row across the top.

## Layer 0

The bonus row serves one-handed numeric entry: cancel, fix a typo, advance a
field, commit. Enter is already on the pad, so the row supplies the other three
plus the layer key.

| Bonus-row slot | Keycode | Why |
| --- | --- | --- |
| 1 | `Esc` | Right-hand Escape, distinct from Caps-tap on the main board |
| 2 | `Backspace` | The one non-numeric key numeric entry actually needs |
| 3 | `Tab` | Next field in spreadsheets and web forms |
| 4 | `MO(1)` | Hold for Layer 1 |

The rest of layer 0 stays factory. Num Lock is not a real toggle on macOS
(`KC_NUM` sends Clear) and the digit keys send digits regardless, so that
position is free to repurpose.

## Layer 1

**Why the F keys live here.** The Neo65 has no dedicated F row and the Neo75
does. A layer key cannot fix that from the numpad, because layers do not cross
devices, so the F row is placed on the numpad itself. The digit grid maps onto
F1 to F12 so the printed legend already tells you the F number:

```
NumLock   /     *      -
  F10    F11   F12    ----

   7      8     9      +
  F7     F8    F9     ----

   4      5     6
  F4     F5    F6

   1      2     3    Enter
  F1     F2    F3    ----
```

F10, F11 and F12 sit directly above F7, F8, F9, so the grid keeps counting
upward the way 7 8 9 already sits above 4 5 6.

Bonus row on layer 1:

| Slot | Keycode |
| --- | --- |
| 1 | `RGB_TOG` |
| 2 | `RGB_MOD` |
| 3 | `BATQ` (custom; battery query, the only way to check charge) |
| 4 | held, `KC_TRNS` |

Test the standard `RGB_*` keycodes first. If they do nothing in this firmware,
fall back to the vendor custom `RL_MOD` (side light mode) and drive brightness,
effect and colour from VIA's Lighting tab instead.

Everything else on layer 1 stays `KC_TRNS`, same convention as the Neo boards.

## Layer 2

Before spending keys on it, check whether the board has a physical mode switch
or factory `Fn` chords for connection switching. If it does not, the five
wireless keycodes need homes, and layer 2 is the right place: rarely used, and a
mis-hold on layer 1 should not be able to drop the Bluetooth connection
mid-work. Reach it with `MO(2)` on layer 1's `.` key, the closest free key to
the `MO(1)` column.

## Custom keycodes in the definition

Usable: `DEV USB`, `DEV BT1`, `DEV BT2`, `DEV BT3`, `DEV 2.4G`, `BATQ`,
`RL_MOD` (side light mode), `WIR_MOD` (connection mode), `LED_TOG` (indicator
LED).

Do not place: `KC_TESTW` (display test white), `FREQU_T` (frequency test),
`BT_TEST` (no-secret pairing channel). These are factory test modes.

## Status

Layer 0 bonus row and layer 1 decided 2026-09-02, not yet entered in VIA.
Export the layout into this directory once it is.
