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

## Target keymap: two-thumb media layer

Needs **Windows mode** (base layer 0), the only mode with two layers above the
base, so it can hold an F-key layer and a separate media layer. macOS does not
care which mode the board is in.

| Layer | Role | Fn (left of ←) | First right of Space |
| --- | --- | --- | --- |
| 0 | Base, split-Backspace top row, `Del` top-right | `MO(1)` | `RWin` |
| 1 | F1-F12 on the number row, connection keys | held | `MO(3)` |
| 2 | Mac-mode fallback, copy of layer 0 | `MO(3)` | `RWin` |
| 3 | Media on the number row, `MD_USB` on Tab, `U_EE_CLR` top-right | held | held |

Hold Fn for F-keys, add the right-thumb key for media. This is the setup that
worked before the rebuild, except that media moved from layer 2 to layer 3.
**Media must never be on layer 2**: in Mac mode layer 2 becomes the base, and a
media layer with no Fn key as the base is exactly the 2026-09-27 lockout.

- Layer 2 is a copy of layer 0 except its Fn key, which must be `MO(3)`. If the
  board flips to Mac mode, typing is unchanged and Fn reaches media and
  `MD_USB`; only the F-keys are gone until the mode is switched back.
- Connection keys use the factory placement on layers 1 and 3: `MD_USB` on
  Tab, `MD_BLE1`-`3` on Q/W/E, `MD_24G` on R, so Qwertykeys' docs apply.
- Keep `U_EE_CLR` top-right on layers 1 and 3. `Fn` + top-right held 3 s is the
  factory reset, the only reset route that needs no reflash.

## Status 2026-09-27: stuck in Mac mode, unresolved

The board is in **Mac mode**: Fn goes to layer 3 (media), so the F-keys are
unreachable. It was in Windows mode before the rebuild, so the Mac does not
force Mac mode on connect. Tried without success:

- `Fn` + the 2nd bottom-left key (`QK_WLO`, factory LWin position) held 3 s,
  and `Fn` + the 3rd key (`LWin` in this layout). Possibly one attempt flipped
  and the next flipped back; not retried one at a time with a test in between.
- `DF(0)` placed on layer 3 `T` and pressed via Fn. Fn + `3` still gave the
  layer 3 key afterwards, so either the firmware re-applies its saved mode or
  `DF` is not honoured.

The keymap on the board is close to the target table, with `DF(0)` still on
layer 3 `T`. Next steps, in order:

1. Retry the toggle once, carefully: hold Fn, hold the 2nd bottom-left key for
   5 s, release, test Fn + `3` in Karabiner-EventViewer (`f3` means Windows
   mode). Repeat once if it shows media.
2. If that fails, factory reset (`Fn` + top-right, hold 3 s), check the mode,
   use the factory toggle if needed, rebuild the target table from the layer
   screenshots, then unplug and replug to confirm Windows mode sticks.
3. Fallback if Windows mode will not stick: put F-keys and media on the same
   Fn layer (F-row on the numbers, media on arrows and `M`/`J`/`K`/`L`), mirrored
   on layers 1 and 3. Works in either mode, loses the two-thumb media layer.

VIA's "Save Current Layout" download did not work from Chrome, so the layer
screenshots are the only backup of the keymap.

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

**Factory reset** is the placeable `U_EE_CLR` keycode, not firmware-trapped.
Holding the top-left key while powering up only enters DFU mode; it does not
clear the saved connection mode, so `U_EE_CLR` is the real reset.

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

- Getting back to Windows mode, see the status section above.
- Final navigation-column order.
