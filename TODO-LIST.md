[< Back to the READ ME](./README.md)

# To Do List
Here are all the things that I still want to do to make the operating system perfect. This is how I would configure my operating system. Meaning that these 'demands' are subjective and my taste.

## Configuration
Some point
- [x] modularity of the configurations:  
  - [x] create the 'module loader' that loads modules based on settings.  
  - [x] make it possible to load the config of a certain machine using the flake.  

## Usability
Here are some things that I still want to configure for the system to be as usable as possible:
- [x] Add "boot to windows" option when booting up.  
- [x] Fix keybindings using the config files so that every machine is immediately fixed. 
- [ ] configure the a window manager.  
  - [ ] i3WM
  - [ ] hyprland
- [ ] configure the application launcher.
- [ ] install all apps that I need.
- [ ] Add fonts using the config.

### Key bindings
The following things need to remapped to have the following effect:
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
- [x] Remap the linux modifiers to the Mac modifiers so the system behaves like a Mac.  

The Keys are written down as Mac keys. So `CMD` would be the the key next to the space bar, `ALT` is on the left of `CMD` and `CTRL` is to the left of that.

### Configure the Window Manager
All the things the Window Manager needs to do:
- [ ] Start apps on their virtual desktops/spaces. This has been implemented on:
   - [x] i3wm
   - [ ] hyprland
- [ ] When an application is opened using the app launcher, you must be transported to that virtual desktop. This has been implemented on:
   - [x] i3wm
   - [ ] hyprland
- [ ] use the wallpaper. This has been implemented on:
   - [x] i3wm
   - [ ] hyprland
- [ ] The time must be show at the top right. This has been implemented on:
   - [ ] i3wm
   - [ ] hyprland
- [ ] The window manager must be able to deal with having a display connected of disconnected and change accordingly. This has been implemented on:
   - [ ] i3wm
   - [ ] hyprland
- [ ] The main font should be OpenDyslexic. This has been implemented on:
   - [ ] i3wm
   - [ ] hyprland
  
#### Window Manager Keybindings
- [ ] `CMD + SPACE` must open the Application Launcher. This a been implemented on:
   - [x] i3wm
   - [ ] hyprland
- [ ] Moving between workspaces.
  - [ ] Pressing `CTRL + INDEX` must bring you to the virtual desktop/ workspace at that index. So `CTRL + 1` will bring you to the Terminal, and `CTRL + 3` will get you to firefox. This has been implemented on:
    - [x] i3wm
    - [ ] hyprland
  - [ ] Pressing `CTRL + ARROW` must bring you to the virtual desktop/ workspace at in that direction. So `CTRL + LEFT` will bring you to a workspace on the left. This has been implemented on:
    - [ ] i3wm
    - [ ] hyprland
- [ ] Moving between displays:
  - [ ] Pressing `CTRL + ALT + INDEX` must move the focus to a different display. So `CTRL + SHIFT + 1` will move it to the primary display.
    - [ ] i3wm
    - [ ] hyprland
  - [ ] Pressing `CTRL + ALT + ARROW`  must move the focus to a different display. `CTRL + SHIFT + LEFT` will move focus to the display on the left.
    - [ ] i3wm
    - [ ] hyprland
- [ ] Moving windows between workspaces:
  - [ ] Pressing `CTRL + SHIFT + INDEX` will move a window to a different workspace. So `CTRL + SHIFT + 1` will move it to the Terminal workspace, and `CTRL + SHIFT + 3` will move it to the browser workspace. This has been implemented on:
    - [x] i3wm
    - [ ] hyprland
  - [ ] Pressing `CTRL + SHIFT + ARROW` will move a window to a different workspace. For example pressing `CTRL + SHIFT + LEFT` will move the window to the workspace on the left. This has been implemented on:
    - [ ] i3wm
    - [ ] hyprland
- [ ] Moving windows between diplays:
  - [ ] Pressing `CTRL + ALT + SHIFT + INDEX` must move the window in focus to a different display. So `CTRL + SHIFT + SHIFT + 1` will move it to the primary display.
    - [ ] i3wm
    - [ ] hyprland
  - [ ] Pressing `CTRL + ALT + SHIFT + ARROW` must move the window in focus to a different display. `CTRL + SHIFT + SHIFT + LEFT` will move focus to the display on the left.
    - [ ] i3wm
    - [ ] hyprland

##### Other important notes
- Workspaces should be window dependent. So workspace 1 is a different workspace on display 1 as it is on display 2.
- The Keys are written down as Mac keys. So `CMD` would be the the key next to the space bar, `ALT` is on the left of `CMD` and `CTRL` is to the left of that.
- When saying `ARROW` this could be either the arrow keys, or the VIM bindings.

#### List of Virtual Desktops/ Work Spaces
Here are the workspaces and their content:
1. Terminals  
2. Code/File editors  
3. Browsers  
4. Communication  
5. File Browsers and Virtual Machines  

### Configure the Application Launcher
Here are the things a application launcher needs to do:
- [x] must launch applications.   
- [ ] must be able to search for files and folders.   
- [ ] must take commands:   
  - [ ] sleep   
  - [ ] hibernate   
  - [ ] reboot   
  - [ ] shut down   
- [ ] must be able to calculate, and convert unites naturally.   
- [ ] must be able to run terminal commands when starting a search with `>`.   

### Install all the apps 
Here is a list of apps that still need to be installed:

#### Terminals
- [x] alacrity

#### Terminal Utilities
- [ ] grep
- [ ] curl
- [ ] wget 
- [ ] zoxide
- [ ] htop
- [ ] fzf
- [x] git
- [ ] ffmpeg

#### Code/File Editors
- [x] Nano
- [x] Vim
- [ ] NeoVim
- [x] VS Code
- [ ] Arduino IDE
- [ ] Notepad++
- [ ] obsidian

#### Communication
- [x] discord
- [ ] Whatsapp
- [x] telegram
- [ ] an email client

#### File browsers

#### Virtual machines
- [x] virtual box
- [ ] docker
  - [ ] docker compose
  - [ ] docker desktop
  - [ ] docker cli
- [ ] Dolphin

#### Game Launchers
- [x] steam
- [ ] epic games
  
### Fonts
Here are some fonts that I still want to add to the machine:
- [ ] OpenDyslexic