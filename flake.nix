# {
#     description = "The flake the controle what machines configurations to use.";
# 
#     inputs = {
#         nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
#     };
# 
#     outputs = { self, nixpkgs } : {
#         default = "default";
#         laptop = "laptop";
#         desktop = "desktop";
#     };
# }
# 

{
    description = "The flake that controls which machine configuration to use.";
  
    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
  
    outputs = { self, nixpkgs, ... }: {
        # Import laptop and desktop configurations
        laptopConfig = import ./system/laptops/thinkpad/configuration.nix { inherit nixpkgs; };
        desktopConfig = import ./system/desktops/home/configuration.nix { inherit nixpkgs; };

        # Define outputs to switch between configurations
        defaultPackage = {
        inherit (nixpkgs) pkgs;
            package = pkgs.lib.mkMerge [ 
                laptopConfig.config 
                desktopConfig.config 
            ];
        };

        # Output for laptop configuration
        laptop = {
            system = "x86_64-linux";
            config = {
                ...defaultPackage.config // laptopConfig.overrides;
            };
        };

        # Output for desktop configuration
        desktop = {
            system = "x86_64-linux";
            config = {
                ...defaultPackage.config // desktopConfig.overrides;
            };
        };
    };
}

