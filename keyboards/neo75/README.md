# QwertyKeys Neo75 CU

Last updated: 2026-09-02

The daily driver. See `../README.md` for the shared base layer and Layer 1 that
this board holds in common with the Neo65, and for the Karabiner rules.

## Hardware

- QwertyKeys Neo75 CU, copper weight
- **ANSI** physical layout
- Power 2048 keycaps
- Tri-mode: USB, Bluetooth, 2.4 GHz

## VIA definition

`neo75-via-definition.json`.

| Field | Value |
| --- | --- |
| Name | `NEO75` |
| Vendor ID | `0x36B0` (14000) |
| Product ID | `0x3021` (12321) |
| Matrix | 6 rows x 16 cols |
| Format | **VIA V2** |

Because it is a V2 file, VIA needs Settings, **"Use V2 definitions"** turned on
before the Design tab will accept it. The Stars21 needs that toggle off, so
expect to flip it when moving between boards.

### Layout options

The definition exposes four optional layout choices. Set them in VIA's Layouts
section to match the physical build before editing any key, or the rendered
board will not correspond to what is under your fingers:

| Option | Setting for this board |
| --- | --- |
| Split Backspace | match the build |
| ISO Enter | **off**, this is an ANSI board |
| Split Left Shift | match the build |
| Bottom Row | 6.25U or 7U, match the spacebar |

Custom keycodes in the definition: `MD_USB`, `MD_BLE1`, `MD_BLE2`, `MD_BLE3`,
`MD_24G`, `QK_BAT` (battery), `QK_WLO`, `SIX_N`, `RGB_RTOG`.

## Board-specific keys

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

## Layer structure, open question

VIA exposes four layers and all four differ. Determine whether layer 2 is the
Windows base layer before using it for anything:

- If layer 2 looks like a near-copy of layer 0 with only the bottom-row
  modifiers reordered (Command/Option swapped for Win/Alt), it is the Windows
  base layer and is spoken for. Every future base-layer change must then be made
  twice, and the Windows-side layer key must be `MO(3)`, not `MO(1)`.
- If layer 2 is unrelated to a base layout, it is genuinely free.

This is no longer blocking, because the connection keycodes moved to Layer 1 and
layers 2 and 3 are not needed for the current design. The same question will
apply to the Neo65.
