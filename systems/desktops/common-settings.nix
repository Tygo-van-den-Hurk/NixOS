let 
    common-settings = import ../common-settings.nix // {
        # Override `../common-settings` to be laptop specific.
    };
in common-settings