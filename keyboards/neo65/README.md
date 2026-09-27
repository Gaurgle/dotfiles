# QwertyKeys Neo65 CU

Last updated: 2026-09-27

Built with split Backspace. See `../README.md` for the shared base layer and
Layer 1 this board must implement, and `../neo75/README.md` for the board it
mirrors.

## VIA definition

`neo65cu-via-definition.json`, the official tri-mode file from the
[Qwertykeys firmware page](https://www.qwertykeys.com/pages/fw).

| Field | Value |
| --- | --- |
| Name | `Neo 65Cu` |
| Vendor ID | `0x36B0` |
| Product ID | `0x3060` |
| Matrix | 6 rows x 16 cols |
| Format | **VIA V3** |

V3, unlike the Neo75: VIA's Settings, "Use V2 definitions" must be **off**. The
tri-mode PCB only works in VIA with the tri-mode JSON, and VIA only sees the
board over USB in wired mode.

Layout options: Split Backspace (**on**, matches the build), Split Enter, Split
Left Shift, Bottom Row. Set them before editing any key.

Custom keycodes: `MD_USB`, `MD_BLE1`, `MD_BLE2`, `MD_BLE3`, `MD_24G`, `QK_BAT`
(battery), `QK_WLO` (Win lock), `SIX_N` (6KRO/NKRO), `SIRI`, `RGB_RTOG`,
`U_EE_CLR` (EEPROM clear).

Official firmware is `Neo_65Cu-v1.01.bin` on the same page. On macOS it flashes
by copying the `.bin` onto the "No Name" disk the board mounts in DFU mode
(battery switch off, hold the top-left key while plugging in USB). Qwertykeys
advise against flashing to fix pairing or VIA problems; it is a last resort.

## Layers: Windows is 0/1, Mac is 2/3

From the official build guide: layers 0 and 1 are the **Windows** base and Fn
layers, layers 2 and 3 are the **Mac** base and Fn layers. Holding `Fn` + LWin
for 3 seconds toggles the mode (Caps Lock LED flashes 3 times).

**Every base layer needs a working Fn key**, `MO(1)` on layer 0 and `MO(3)` on
layer 2, left of Left Arrow. All mode switching, pairing and reset chords go
through Fn. Put `MD_USB` on both Fn layers so wired mode is always reachable,
and keep layers 1 and 3 identical so a mode flip changes nothing.

**In Mac mode the Fn key must be `MO(3)`, never `MO(1)`.** QMK resolves each key
from the highest active layer, and the default layer counts. With layer 2 as the
base, `MO(1)` switches on a layer that sits below it, so layer 2 still wins and
the key behaves as if Fn does nothing. Every other keycode works, which makes it
look like a dead switch.

On 2026-09-27 this caused a full lockout: the board was in Mac mode with no
working Fn on layer 2, stuck on BT2 with the Mac pairing forgotten, and no
chord could reach USB. Holding the Fn key still lights the connection LED, so
that is no proof the layer switched; test with Fn + `3` in Karabiner-EventViewer,
which should show `f3`.

## Base layer, board-specific

| Position | Mapping |
| --- | --- |
| Top-left | `KC_GRV`, backtick and tilde |
| Caps Lock position | Must stay `KC_CAPS` |
| First right of Space | `RWin` |
| Key immediately left of Left Arrow | `MO(1)` on layer 0, `MO(3)` on layer 2 |

Bottom row confirmed at build: three keys left of Space, two right, so `RWin`
and `MO(1)` are adjacent.

The board has no dedicated Escape, so the top-left key is remapped from Escape
to `KC_GRV` and Escape comes from Caps Lock tap, with `MO(1)` + backtick as the
Karabiner-free fallback.

The Caps Lock position is a hard constraint. Karabiner matches on the
`caps_lock` key code, so remapping it in VIA silently breaks both tap-Escape and
hold-Hyper.

## Tri-mode shortcuts

Factory defaults from the official
[Neo65 & 60 Cu build guide](https://qwertykeys.notion.site/Neo65-60-Cu-Build-Guide-1863d090094280babee7ce4ff3901aa8).
`Fn` is the key left of Left Arrow.

| Combination | Tap | Hold 3 seconds |
| --- | --- | --- |
| `Fn` + Tab | Wired mode | n/a |
| `Fn` + `Q` / `W` / `E` | Bluetooth 1 / 2 / 3 | Re-pair that slot |
| `Fn` + `R` | 2.4 GHz mode | Re-pair the dongle |
| `Fn` + LWin | Win key lock | Toggle Win/Mac mode |
| `Fn` + `D` | Battery level on the 1-4 LEDs, 25% each | n/a |
| `Fn` + Delete | n/a | Factory reset |

LED under Esc/~ flashing means wired mode. A white indicator flashes fast while
pairing and slowly while reconnecting; after 60 s without pairing or 20 s
without reconnecting the board sleeps, and any key press wakes it to try again.
The battery power switch is under Caps Lock.

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

- Whether to live in Mac mode (layers 2/3) or Windows mode (layers 0/1). The
  shared keymap in `../README.md` is written as layers 0/1.
- Final navigation-column order.
