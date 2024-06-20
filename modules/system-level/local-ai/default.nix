
## Enable Ollama and open-webui as a service, and run it in the background.

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    local-ai-settings = ( builtins.trace 
        "Loading: /modules/system-level/local-ai..." 
        machine-settings.system.modules.local-ai
    ); 

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

    # containerization-is-enabled = virtualisation.containers.enable == true;
    # podman-is-enabled = virtualisation.podman.enable == true;
    # docker-is-enabled = virtualisation.docker.enable == true;

    # assert ( containerization-is-enabled && ( podman-is-enabled || docker-is-enabled ) );
    
in {

    services.ollama = {
        package = pkgs.ollama;
        enable = true;
        # These should all be auto detected
        # acceleration = local-ai-settings.acceleration;
        # environmentVariables = {
            # HIP_VISIBLE_DEVICES = "0,1";
            # CUDA_VISIBLE_DEVICES = "0";
            # OLLAMA_LLM_LIBRARY = "cpu";
            # OLLAMA_MODELS = "/home/ollama/models";
            # OLLAMA_HOST = "0.0.0.0:11434"; # Make Ollama accesible outside of localhost
            # OLLAMA_ORIGINS = "http://localhost:8080,http://192.168.0.10:*"; # Allow access, otherwise Ollama returns 403 forbidden due to CORS
        # };
    };

    environment.systemPackages = with pkgs; [
        oterm                                       # this is a CLI chat interface for Ollama
        # TODO : Set up fabric here
    ];

    system.activationScripts.create-folders-for-local-ai-volumes.text = (''
        install -d -m 755 ${open-webui-path} -o root -g root
    '');

    virtualisation.oci-containers.backend = "docker";
    # ( 
    #     if docker-is-enabled then "docker" else 
    #     if podman-is-enabled then "podman" else 
    #     abort "unknow container host requested."
    #     + "See \'local-ai\' module for more." 
    # );

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
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ END ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
