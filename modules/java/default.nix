## installs java on the system.

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    javaPackage = builtins.trace ("Loading: ${toString ./.}... (requested java version: ${__java_})") (__java_); 
    __java_ = machine-settings.modules.java;

in 

#! The java version must be specified in the variable !#
assert ( javaPackage != "" && javaPackage != false); 
#! The java version must be specified in the variable !#

{ 

    environment.systemPackages = ( with pkgs; [ maven gradle ] );

    programs.java = { 
        enable = true; 
        package = (

            if ( javaPackage == "jdk21_headless" ) then ( pkgs.jdk21_headless ) else 
            if ( javaPackage == "jdk21"          ) then ( pkgs.jdk21          ) else          
            if ( javaPackage == "jdk20_headless" ) then ( pkgs.jdk20_headless ) else 
            if ( javaPackage == "jdk20"          ) then ( pkgs.jdk20          ) else          
            if ( javaPackage == "jdk19_headless" ) then ( pkgs.jdk19_headless ) else 
            if ( javaPackage == "jdk19"          ) then ( pkgs.jdk19          ) else          
            if ( javaPackage == "jdk18_headless" ) then ( pkgs.jdk18_headless ) else 
            if ( javaPackage == "jdk18"          ) then ( pkgs.jdk18          ) else          
            if ( javaPackage == "jdk17_headless" ) then ( pkgs.jdk17_headless ) else 
            if ( javaPackage == "jdk17"          ) then ( pkgs.jdk17          ) else          
            if ( javaPackage == "jdk16_headless" ) then ( pkgs.jdk16_headless ) else  
            if ( javaPackage == "jdk16"          ) then ( pkgs.jdk16          ) else           
            if ( javaPackage == "jdk15_headless" ) then ( pkgs.jdk15_headless ) else 
            if ( javaPackage == "jdk15"          ) then ( pkgs.jdk15          ) else          
            if ( javaPackage == "jdk14_headless" ) then ( pkgs.jdk14_headless ) else 
            if ( javaPackage == "jdk14"          ) then ( pkgs.jdk14          ) else          
            if ( javaPackage == "jdk13_headless" ) then ( pkgs.jdk13_headless ) else 
            if ( javaPackage == "jdk13"          ) then ( pkgs.jdk13          ) else          
            if ( javaPackage == "jdk12_headless" ) then ( pkgs.jdk12_headless ) else 
            if ( javaPackage == "jdk12"          ) then ( pkgs.jdk12          ) else          
            if ( javaPackage == "jdk11_headless" ) then ( pkgs.jdk11_headless ) else 
            if ( javaPackage == "jdk11"          ) then ( pkgs.jdk11          ) else          
            if ( javaPackage == "jdk10_headless" ) then ( pkgs.jdk10_headless ) else 
            if ( javaPackage == "jdk10"          ) then ( pkgs.jdk10          ) else          
            if ( javaPackage == "jdk9_headless"  ) then ( pkgs.jdk9_headless  ) else 
            if ( javaPackage == "jdk9"           ) then ( pkgs.jdk9           ) else          
            if ( javaPackage == "jdk8_headless"  ) then ( pkgs.jdk8_headless  ) else 
            if ( javaPackage == "jdk8"           ) then ( pkgs.jdk8           ) else          
            if ( javaPackage == "jdk7_headless"  ) then ( pkgs.jdk7_headless  ) else 
            if ( javaPackage == "jdk7"           ) then ( pkgs.jdk7           ) else          
            if ( javaPackage == "jdk6_headless"  ) then ( pkgs.jdk6_headless  ) else 
            if ( javaPackage == "jdk6"           ) then ( pkgs.jdk6           ) else          
            if ( javaPackage == "jdk5_headless"  ) then ( pkgs.jdk5_headless  ) else 
            if ( javaPackage == "jdk5"           ) then ( pkgs.jdk5           ) else          
            if ( javaPackage == "jdk4_headless"  ) then ( pkgs.jdk4_headless  ) else 
            if ( javaPackage == "jdk4"           ) then ( pkgs.jdk4           ) else          
            if ( javaPackage == "jdk3_headless"  ) then ( pkgs.jdk3_headless  ) else 
            if ( javaPackage == "jdk3"           ) then ( pkgs.jdk3           ) else          
            if ( javaPackage == "jdk2_headless"  ) then ( pkgs.jdk2_headless  ) else 
            if ( javaPackage == "jdk2"           ) then ( pkgs.jdk2           ) else          
            if ( javaPackage == "jdk1_headless"  ) then ( pkgs.jdk1_headless  ) else 
            if ( javaPackage == "jdk1"           ) then ( pkgs.jdk1           ) else          
            abort "The java package: \"${javaPackage}\" is not an option you could chose."
        
        ); 
    };
}

