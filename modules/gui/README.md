# Configurations for the Window Manager
All the things the Window Manager needs to do:
- [ ] Start apps on their [virtual desktops/spaces](#work-spaces--virtual-desktops). This has been implemented on:
   - [x] i3wm
   - [ ] hyprland
- [ ] When an application is opened using the app launcher, you must be transported to that virtual desktop. This has been implemented on:
   - [x] i3wm
   - [ ] hyprland
- [ ] use the wallpaper. This has been implemented on:
   - [x] i3wm
   - [ ] hyprland
- [ ] The time must be show at the top right. This has been implemented on:
   - [x] i3wm
   - [ ] hyprland
- [ ] The window manager must be able to deal with having a display connected of disconnected and change accordingly. This has been implemented on:
   - [ ] i3wm
   - [ ] hyprland
- [ ] The main font should be OpenDyslexic. This has been implemented on:
   - [x] i3wm
   - [ ] hyprland

## Work Spaces / Virtual Desktops
- **Workspace 1**: Is used for the terminal.
  - alacrity
  - kitty
- **Workspace 2**: Is used for file/code editors.
  - VS Code
  - Only office
- **Workspace 3**: Is used for browsers.
  - Firefox
  - Brave
  - Chromium
- **Workspace 4**: Is used for the window stack. This entails:
  - Communication: 
    - Whatsapp
    - Telegram
  - Music:
    - Apple Music 
    - Spotify

## Key bindings
Before we start, the following keys are written down as Mac keys. See the [key remapper documentation](../key-remapper/README.md) for more information. When interacting with the window manager, you'll use the `CTRL` modifier as the primary modifier. First, we'll order the actions based on how frequent they should occur. 

### How much should an action occur
These are the actions you can take:
- Switch layouts
- Switching focus between windows on the same workspace.
- Switching focus between windows a different workspace.
- Switching focus between windows a different display.
- Switching focus to a different windows at an unknown location.
- Moving windows on the same workspace.
- Moving windows to a different workspace.
- Moving windows to a different display.

Now let's order them based on how often they should happen. 

#### Moving Focus between Work Spaces or Displays
Based on if you have one or two displays you are either moving focus between workspaces, or displays. That's why they're both just as important, and on number one. 

This is as switching to a workspace should do the same as switching to a specific application.

#### Moving Windows between Work Spaces or Displays
Since you're not supposed to have to move windows this is less important. They're supposed to spawn in where they belong when needed.

#### Moving Focus on the same Work Spaces and Display
As you're not really supposed to have more then one window open at a time for a given type it does not come as a surprise that moving focus between them is not the goal and but sometimes has to be done.

#### Moving Windows on the same Work Spaces and Display
As switching focus between windows on the same workspace and display wasn't favorable, you can assume that moving them around is even worse.

#### Switching to an application at an unknown location
Knowing where an application is, is an advantage. This means that you should be able to go exactly to this application in a single button press. Since you don't always know Where an application is, it still needs to be possible to find this application and go there. It just shouldn't happen alot.

#### Switching layouts
As you're not supposed to have multiple windows on the same workspace and move them, changing how they're displayed is obviously not a thing we're supposed to do

#### The results
1. Switching focus to a different Workspace / Display:
    - Switching focus between windows a different workspace. [Go here](#moving-focus-between-work-spaces).
    - Switching focus between windows a different display. [Go here](#moving-focus-between-displays).
3. Moving a window to a different wWorkspace / Display:
    - Moving windows to a different workspace.
    - Moving windows to a different display.
6. Switching focus between windows on the same workspace.
5. Moving windows on the same workspace.
4. Switching focus to a different windows at an unknown location.
5. Switch layouts. [Go here](#switching-layouts).

We'll go over them in the same order.

### Moving Focus between Work Spaces
Pressing `CTRL + INDEX` must bring you to the virtual desktop/ workspace at that index. So `CTRL + 1` will bring you to the first workspace (the one all the way on the left), and `CTRL + 3` will get you to the third workspace. This has been implemented on:
- [x] i3wm
- [ ] hyprland

Pressing `CTRL + ARROW` must bring you to the virtual desktop/ workspace at in that direction. So `CTRL + LEFT` will bring you to a workspace on the left. This has been implemented on:
- [x] i3wm
- [ ] hyprland

### Moving Focus between Displays
Pressing `CTRL + ALT + INDEX` must move the focus to a different display. So `CTRL + ALT + 1` will move it to the primary display.
- [ ] i3wm
- [ ] hyprland

Pressing `CTRL + ALT + ARROW`  must move the focus to a different display. `CTRL + ALT + LEFT` will move focus to the display on the left.
- [ ] i3wm
- [ ] hyprland

### Moving Windows between Work Spaces
Pressing `CTRL + SHIFT + INDEX` will move a window to a different workspace. So `CTRL + SHIFT + 1` will move it to the Terminal workspace, and `CTRL + SHIFT + 3` will move it to the browser workspace. This has been implemented on:
- [x] i3wm
- [ ] hyprland

Pressing `CTRL + SHIFT + ARROW` will move a window to a different workspace. For example pressing `CTRL + SHIFT + LEFT` will move the window to the workspace on the left. This has been implemented on:
- [ ] i3wm
- [ ] hyprland

### Moving Windows between Displays
Pressing `CTRL + ALT + SHIFT + INDEX` must move the window in focus to a different display. So `CTRL + SHIFT + SHIFT + 1` will move it to the primary display.
- [ ] i3wm
- [ ] hyprland

Pressing `CTRL + ALT + SHIFT + ARROW` must move the window in focus to a different display. `CTRL + SHIFT + SHIFT + LEFT` will move focus to the display on the left.
- [ ] i3wm
- [ ] hyprland

### Moving Focus between windows on the same Work Space and Display
Pressing `CTRL + CMD + ARROW` must change focus to the window in the direction of the arrow. This has been implemented on:
- [ ] i3wm
- [ ] hyprland

### Moving Windows on the same Work Space and Display
Pressing `CTRL + CMD + SHIFT + ARROW` must switch the windows position with the window in the direction of the arrow. This has been implemented on:
- [ ] i3wm
- [ ] hyprland

### Switching focus to a different windows at an unknown location.
Pressing `CMD + Tab` must cycle between the applications, while adding shift should cycle backwards. This has been implemented on:
- [ ] i3wm
- [ ] hyprland

### Switching layouts
Pressing `CTRL + M` must switch to the master layout. This has been implemented on:
- [x] i3wm
- [ ] hyprland

Pressing `CTRL + S` must switch to the split layout. This has been implemented on:
- [x] i3wm
- [ ] hyprland

Pressing `CTRL + T` must switch to the tabbed layout. This has been implemented on:
- [x] i3wm
- [ ] hyprland

### Other important notes
- Workspaces should be window dependent. So workspace 1 is a different workspace on display 1 as it is on display 2. This means that pressing the keyboard shortcut to go to workspace 1 should bring you to workspace 1 on that display.
- When saying `ARROW` this could be either the arrow keys, or the VIM bindings.
  