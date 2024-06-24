
## Enable Ollama and open-webui as a service, and run it in the background.

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    module-settings = (builtins.trace "Loading: ${toString ./.}..." machine-settings.system.modules.local-ai); 

    #
    # Created with help of: 
    #
    #`  https://fictionbecomesfact.com/nixos-ollama-oterm-openwebui
    #
    # To debug a docker container use: 
    #
    #`  journalctl _SYSTEMD_INVOCATION_ID=$(systemctl show -p InvocationID --value docker-open-webui.service) --no-pager
    #

    open-webui-path = "/var/lib/private/open-webui/";
        
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Making an assertion ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
    
in ( if module-settings.enable == true then {

    services.ollama = {
        package = pkgs.ollama;
        enable = true;
        acceleration = module-settings.acceleration;
        environmentVariables = {
            HIP_VISIBLE_DEVICES = module-settings.devices.hip;
            CUDA_VISIBLE_DEVICES = module-settings.devices.cuda;
            # OLLAMA_LLM_LIBRARY = "cpu";
            # OLLAMA_HOST = "0.0.0.0:11434"; # Make Ollama accesible outside of localhost
            OLLAMA_ORIGINS = "http://localhost:*,http://127.0.0.1:*"; # CORS
        };
    };

    environment.systemPackages = with pkgs; [
        oterm                                       # this is a CLI chat interface for Ollama
        # TODO : Set up fabric here
    ];

    system.activationScripts.create-folders-for-local-ai-volumes.text = (''
        install -d -m 755 ${open-webui-path} -o root -g root
    '');

    virtualisation.oci-containers.backend = module-settings.backend;
    virtualisation.oci-containers.containers = {

        #| Open web ui
        "open-webui" = {
            hostname = "open-webui";
            image = "ghcr.io/open-webui/open-webui:main";
            autoStart = true;
            volumes = [ "${open-webui-path}:/app/backend/data"];
            environment = {
                WEBUI_AUTH      = "True";
                ENABLE_SIGNUP   = "True";
                WEBUI_NAME      = "Local AI";
                CUSTOM_NAME     = "Local AI";
                STATIC_DIR      = "./static";
                OLLAMA_BASE_URL = "http://127.0.0.1:11434";
                # OPENAI_API_KEY  = "${sercrets.OPENAI_API_KEY}";
            };
            extraOptions = [
                "--pull=missing"
                "--network=host"
                "--add-host=host.containers.internal:host-gateway"
            ];
        };
    };

} else { } )

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ END ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
