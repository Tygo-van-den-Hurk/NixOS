arguments @ { input, machine-settings, ... } :

let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = ( builtins.trace ("Loading: /modules/key-remapper/xremap...") ( true ) ); 

    #// path-to-config = /home/${machine-settings.user.username}/.config/xremap/config;

in { imports = [ input.xremap-flake.nixosModules.default ];

    hardware.uinput.enable = yes;

    users.groups.uinput.members = [ machine-settings.user.username ];
    users.groups.input.members  = [ machine-settings.user.username ];

    services.xremap = {
        withWlroots = yes; # TODO : Figure out what EXACTLY this setting does.
        # withHypr  = yes;
        userName    = machine-settings.user.username;
        yamlConfig  = (''
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN XREMAP CONFIGURATION FILE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
## Generated from: '.../NixOS/modules/xremap/defaul.nix' at 'services.xremap.yamlConfig'.
#! Do not edit this YAML file, it is read only, edit the configuration mentioned above. 
# Read https://github.com/xremap/xremap/blob/master/README.md for more information.
#
#~ Remapping modifiers
# this part will remap windows/linux modifiers to function like mac modifiers. 
# This is what the keys and their function are on respective platforms:
#
#   +---------+----------------+-------+--------+-------+--------+
#   : OS      : L_Key : L_func : M_Key : M_func : R_Key : R_func :
#   +---------+-------+--------+-------+--------+-------+--------+
#   : Windows : CTRL  :  MAIN  :  WIN  : THIRD  :  ALT  :  SEC   :
#   +---------+-------+--------+-------+--------+-------+--------+
#   : MacOS   : CTRL  : THIRD  :  ALT  :  SEC   :  CMD  :  MAIN  :
#   +---------+-------+--------+-------+--------+-------+--------+
#
# This means that the following conculsion can be made:
#   - WIN_CTRL  needs to be swapped with WIN_ALT.   ( Primaray   goes to right  key )
#   - WIN_SUPER needs to be swapped with WIN_CTRL.  ( thirdairy  goes to left   key )
#   - WIN_ALT   needs to be swapped with WIN_SUPER. ( secondairy goes to middle key )
#
modmap:
    - name: Global 
      remap:
        ALT_L: CONTROL_L    # WIN_ALT   gets assigned MAC_CMD  (WIN_CTRL)  --> ( Primaray   goes to right  key )
        ALT_R: CONTROL_R    # WIN_ALT   gets assigned MAC_CMD  (WIN_CTRL)  --> ( Primaray   goes to right  key )
        SUPER_L: ALT_L      # WIN_SUPER gets assigned MAC_ALT  (WIN_ALT)   --> ( Secondary goes to middle key )
        SUPER_R: ALT_R      # WIN_SUPER gets assigned MAC_ALT  (WIN_ALT)   --> ( Secondary goes to middle key )
        CONTROL_L: SUPER_L  # WIN_CTRL  gets assigned MAC_CTRL (WIN_SUPER) --> ( Thirdairy  goes to left   key )
        CONTROL_R: SUPER_R  # WIN_CTRL  gets assigned MAC_CTRL (WIN_SUPER) --> ( Thirdairy  goes to left   key )
#
#~ Remapping keycombinations
# this part will be for adding custom keyboard shortcuts, or remapping to existing ones.
# The topics we'll discuss are:
#  - Naviagation & Selection
#  - Deletion
#  - ...
#
keymap:
#   default_mode: default
    - name: general
      # mode: default
      remap:
#
#` Navigation & Selection 
#  Some of my most used commands that are only on MacOS are the navigation commands. Let's start with navigation.
#
#| NAVIGATION
# There is a hiarchy to this. CMD is the primary modifier, and is therefor at the top of the list. It moves the most.
# Then there is ALT, secondary on the list, so moves less then CMD, but still more then CTRL, which is at ht bottom 
# of the list. Lets go over them:
#
# - MAC_CMD + [ LEFT | RIGHT ] --> Move to the BEGINING, or END of the LINE respectively. 
# - MAC_CMD + [ UP   | DOWN  ] --> Move to the BEGINING, or END of the FILE respectively. 
#
# - MAC_ALT + [ LEFT | RIGHT ] --> Move one word LEFT, or RIGHT respectively. 
# - MAC_ALT + [ UP   | DOWN  ] --> Move to the BEGINING, or END of the current alinea respectively. 
#
# TODO : Add the Thirdiary navigation shortcuts
# - MAC_CTRL + [ LEFT | RIGHT ] --> Move to virtual desktop/workspace on the left, or right respectively.
# - MAC_CTRL + [ UP   | DOWN  ] --> show all windows, or show desktop respectively
#  
# So what are these commands on windows and linux? Well, this is what they map to:
# 
# -            [ HOME | END   ] --> Move to the BEGINING, or END of the LINE respectively. 
# - WIN_CTRL + [ HOME | END   ] --> Move to the BEGINING, or END of the FILE respectively. 
#
# - WIN_CTRL + [ LEFT | RIGHT ] --> Move one word LEFT, or RIGHT respectively. 
# - WIN_CTRL + [ UP   | DOWN  ] --> Move to the BEGINING, or END of the current alinea respectively. 
#
# TODO : Add the Thirdiary navigation shortcuts in windows
# ? Depends on the desktop enviorment
# ? Depends on the desktop enviorment
#  
# So that leaves us with this mapping:
#
# - MAC_CMD + [ LEFT | RIGHT ] -->            [ HOME | END   ]
# - MAC_CMD + [ UP   | DOWN  ] --> WIN_CTRL + [ HOME | END   ]
#
# - MAC_ALT + [ LEFT | RIGHT ] --> WIN_CTRL + [ LEFT | RIGHT ]
# - MAC_ALT + [ UP   | DOWN  ] --> WIN_CTRL + [ UP   | DOWN  ]
#  
# Resulting in the following remaps:
#
# Navigation : Primary   : MAC_CMD  ( WIN_ALT )
        Ctrl-Left: Home             # MAC_CMD + Left  --> ( WIN_CTRL + Left  --> ) Home
        Ctrl-Right: End             # MAC_CMD + Right --> ( WIN_CTRL + Right --> ) End
        Ctrl-Up: Ctrl-Home          # MAC_CMD + Up    --> ( WIN_CTRL + Up    --> ) WIN_CTRL + Home
        Ctrl-Down: Ctrl-End         # MAC_CMD + Down  --> ( WIN_CTRL + Down  --> ) WIN_CTRL + End
# Navigation : Secondary : MAC_ALT  ( WIN_SUPER )
        Alt-Left: Ctrl-Left         # MAC_ALT + Left  --> ( WIN_SUPER + Left  --> ) WIN_CTRL + Left
        Alt-Right: Ctrl-Right       # MAC_ALT + Right --> ( WIN_SUPER + Right --> ) WIN_CTRL + Right
        Alt-Up: Ctrl-Up             # MAC_ALT + Up    --> ( WIN_SUPER + Up    --> ) WIN_CTRL + Up
        Alt-Down: Ctrl-Down         # MAC_ALT + Down  --> ( WIN_SUPER + Down  --> ) WIN_CTRL + Down
# Navigation : Thirdiary  : MAC_CTRL ( WIN_CTRL )
#
#| SELECTION
# Selection is nothing more then the navigation, but you hold shift, selecting the distance you've travelled.
# 
# - MAC_CMD  + SHIFT + [ LEFT | RIGHT ] --> Select from here to the BEGINING, or END of the LINE respectively. 
# - MAC_CMD  + SHIFT + [ UP   | DOWN  ] --> Select from here to the BEGINING, or END of the LINE respectively. 
# 
# - MAC_ALT  + SHIFT + [ LEFT | RIGHT ] --> Select from here to one word LEFT, or RIGHT respectively. 
# - MAC_ALT  + SHIFT + [ UP   | DOWN  ] --> Select from here to the BEGINING, or END of the current block respectively. 
#
# They are basically the same but with space added. The conclusion is then also no different:
#  
# Selection : Primary   : MAC_CMD  ( WIN_ALT )
        Ctrl-Shift-Left:  Shift-Home      # MAC_CMD + Shift + Left  --> ( WIN_CTRL + Shift + Left  --> ) Shift + Home
        Ctrl-Shift-Right: Shift-End       # MAC_CMD + Shift + Right --> ( WIN_CTRL + Shift + Right --> ) Shift + End
        Ctrl-Shift-Up:    Ctrl-Shift-Home # MAC_CMD + Shift + Up    --> ( WIN_CTRL + Shift + Up    --> ) WIN_CTRL + Shift + Home
        Ctrl-Shift-Down:  Ctrl-Shift-End  # MAC_CMD + Shift + Down  --> ( WIN_CTRL + Shift + Down  --> ) WIN_CTRL + Shift + End
# Selection : Secondary : MAC_ALT  ( WIN_SUPER )
        Alt-Shift-Left:  Ctrl-Shift-Left  # MAC_ALT + Shift + Left  --> ( WIN_SUPER + Left  --> ) WIN_CTRL + Left
        Alt-Shift-Right: Ctrl-Shift-Right # MAC_ALT + Shift + Right --> ( WIN_SUPER + Right --> ) WIN_CTRL + Right
        Alt-Shift-Up:    Ctrl-Shift-Up    # MAC_ALT + Shift + Up    --> ( WIN_SUPER + Up    --> ) WIN_CTRL + Up
        Alt-Shift-Down:  Ctrl-Shift-Down  # MAC_ALT + Shift + Down  --> ( WIN_SUPER + Down  --> ) WIN_CTRL + Down
# Selection : Thirdiary  : MAC_CTRL ( WIN_CTRL )
#
#| DELETION
# When you press the Primary, Secondary pluse backspace, or delete, it should remove the characters that were travel 
# through. So that would mean that:
# 
# - MAC_CMD  + [ BACK_SPACE | DELETE ] --> Delete from here to the BEGINING, or END of the LINE respectively. 
# - MAC_ALT  + [ BACK_SPACE | DELETE ] --> Delete from here to the PREVIOUS, or NEXT of the WORD respectively. 
# 
# We can use our previously discovered results to to this. Where we add a tiny delay to make sure that it gets deleted
# after it gets selected, as deleting it in one step is not supported.
#
# Deletion : Primary   : MAC_CMD  ( WIN_ALT )
        Ctrl-BackSpace: [ Shift-Home, BackSpace ] # MAC_CMD + BackSpace  --> ( [ WIN_CTRL + Shift + Left, BackSpace ] --> ) [ Shift-Home, BackSpace]
        Ctrl-Delete:    [ Shift-End,  Delete    ] # MAC_CMD + Delete     --> ( [ WIN_CTRL + Shift + Left, Delete    ] --> ) [ Shift-End,  Delete   ]
# Deletion : Secondary : MAC_ALT  ( WIN_SUPER )
        Alt-BackSpace:  [ Ctrl-Shift-Left,  BackSpace ] # MAC_CMD + BackSpace --> ( [ WIN_CTRL + Shift + Left, BackSpace ] --> ) [ Shift-Home, BackSpace]
        Alt-Delete:     [ Ctrl-Shift-Right, Delete    ] # MAC_CMD + Delete    --> ( [ WIN_CTRL + Shift + Left, Delete    ] --> ) [ Shift-End,  Delete   ]
# Deletion : Thirdiary  : MAC_CTRL ( WIN_CTRL )
#
#| Closing DMENU when pressing MAC_CMD + SPACE
    - name: close DMENU with it's activation
      application:
        only: dmenu Brave-browser
      remap:
        # Ctrl-Space: Esc
        Ctrl-Space: 
          launch: ["bash", "-c", "echo hello > /tmp/test"]
#
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ END XREMAP CONFIGURATION FILE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
        '');
    };
}
