> This module loads key remappers as a systemd service.

[< Back to user modules](../README.md)

# Key Remapping

- [Key Remapping](#key-remapping)
  - [Overview](#overview)
    - [Submodules](#submodules)

## Overview 
Key remappers are programs or tools that change what a key on your keyboard does. For example: you can make your Caps Lock key act like an extra Ctrl key. It allows you to customize the way keys work.


### Submodules
There are a couple submodules I've tried to get working:

- [xremap](./xremap/README.md) (recommended)
- [kmonad](./kmonad/README.md) (deprecated)


<!-- 

## Key Remaps
The following things need to remapped to have the following effect:
- [x] Remap the linux modifiers to the Mac modifiers so the system behaves like a Mac. This means that the primary modifier is on the side of the space bar, the secondary key is to the side of that, and lastly where the tertiary key is to the side of that.
- [x] Navigation
  - [x] `CMD + RIGHT` $\rightarrow$ Go to the end of the line.
  - [x] `CMD + LEFT` $\rightarrow$ Go to the beginning of the line.
  - [x] `CMD + DOWN` $\rightarrow$ Go to the end of the file.
  - [x] `CMD + UP` $\rightarrow$ Go to the beginning of the file.
  - [x] `ALT + LEFT` $\rightarrow$ Go one word to the left.
  - [x] `ALT + RIGHT` $\rightarrow$ Go one word to the right
  - [x] `ALT + DOWN` $\rightarrow$ Go to the end of the current alinea.
  - [x] `ALT + UP` $\rightarrow$ Go to the beginning of current alinea.
- [x] Selection
  - [x] `CMD + SHIFT + RIGHT` $\rightarrow$ Select from here to the end of the line.
  - [x] `CMD + SHIFT + LEFT` $\rightarrow$ Select from here to the beginning of the line.
  - [x] `CMD + SHIFT + DOWN` $\rightarrow$ Select from here to the end of the file.
  - [x] `CMD + SHIFT + UP` $\rightarrow$ Select from here to the beginning of the file.
  - [x] `ALT + SHIFT + LEFT` $\rightarrow$ Select from here one word (more) to the left.
  - [x] `ALT + SHIFT + RIGHT` $\rightarrow$ Select from here one word (more) to the right
  - [x] `ALT + SHIFT + DOWN` $\rightarrow$ Select from here to the end of the current alinea.
  - [x] `ALT + SHIFT + UP` $\rightarrow$ Select from here to the beginning of current alinea.
- [x] Deletion
  - [x] `CMD + BACK_SPACE` $\rightarrow$ Delete from here to the beginning of the line.
  - [x] `CMD + DELETE` $\rightarrow$ Delete from here to the end of the line
  - [x] `ALT + BACK_SPACE` $\rightarrow$ Delete from here one word to the left.
  - [x] `ALT + DELETE` $\rightarrow$ Delete from here one word to the right

The Keys are written down as Mac keys. So:
- `CMD` would be the the key next to the space bar, so the primary modifier.
- `ALT` is on the left of `CMD`, and the secondary modifier.
- Lastly `CTRL` is to the left of that, and the tertiary modifier. 
 
-->
