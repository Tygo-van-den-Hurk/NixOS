let
    lib = (import <nixpkgs> {}).lib;
in 


let

    test = "init";

in 
let


    test = (test + "other");

in 

    test

    
# # let
# #     myList = [ ./test1.nix ./test2.nix ];
# # in

# #     # loop over the list:
# #     builtins.listToAttrs ( builtins.map (

# #             key: # lamda(key) --> set
# #                 let 

# #                     fileCont = (import key);

# #                 in 
                
# #                     lib.nameValuePair fileCont.name {
# #                         path = key;
# #                         otherValue = fileCont.otherValue;
# #                     }
# #         ) 
# #         myList
# #     )


# # let
# #     test = "test";
# # in

# # let 
# #     another = "another";
# # in

# # let 
# #     last = "last";
# # in 

# #     {
# #         inherit test;
# #         inherit another;
# #         inherit last;
# #     }
    
# let
#     pathToConfig = ./lap/mod;
# in  
#     # pathToConfig
# let 
#     recursiveMerge = ( import ./../systems/recursive-merge.nix { inherit lib; } );
# in 
#     # recursiveMerge
# let

#     settings = {
#         global   = ( import ( pathToConfig + "/../../common-settings.nix" ) );
#         category = ( import ( pathToConfig + "/../common-settings.nix"    ) );
#         machine  = ( import ( pathToConfig + "/settings.nix"              ) );
#     };
# in 
#     settings
# # let
#     # machine-settings = recursiveMerge [ 
#     #     settings.global 
#     #     settings.category 
#     #     settings.machine 
#     # ];
# # in 
# #     machine-settings
# # let
# #     result = machine-settings // { inherit pathToConfig; };
# # in
# #     result
    
# # let
# #     pathToConfig = ./lap/mod;
# #   commonSettings = ../../common-settings.nix;
# # in
# #   builtins.toFile "result" (builtins.readFile pathToConfig + "/" + builtins.readFile commonSettings)
