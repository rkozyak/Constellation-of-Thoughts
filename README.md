# Constellation of Thoughts

An iOS app for saving short thoughts as stars in a night sky. Each thought is a **star**, and every star belongs to a **constellation** — a theme that groups related thoughts and draws them as a cluster joined by faint lines.

## Screens

| Screen | What it does |
| --- | --- |
| Home | The sky map. Tap a star to read it. |
| Journal | Every star as a list, grouped by constellation. Swipe to delete. |
| New | Save a thought and pick or create its constellation. |
| Account | Placeholder for sign-in. |

## Requirements

- Xcode 27
- iOS 27

## Running it

```
git clone https://github.com/rkozyak/Constellation-of-Thoughts.git
open "Constellation of Thoughts.xcodeproj"
```

Pick a simulator or a connected iPhone and press Run. To run on a device, set your own team under **Signing & Capabilities**.

## How it's built

SwiftUI with SwiftData for local storage — no backend yet, so thoughts live only on the device.

| File | Role |
| --- | --- |
| `Star.swift` | A saved thought, with its position in the sky |
| `Constellation.swift` | A theme, with its color and where its cluster sits |
| `SkyMap.swift` | Draws the stars and the lines between them |

Stars are positioned in normalized sky coordinates from -1 to 1: each constellation gets a center, and its stars scatter around it. The position is set once when the star is created, so the sky never rearranges itself.
