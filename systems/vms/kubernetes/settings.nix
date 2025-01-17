## This is the specific Setting file for this machine
#! Any setting you write here will overwrite whatever anyone has tried to set before.
{ # add updates below:

  users = {
    tygo.init.modules = { 
        docker.enable = true;
    };
  };

  system = {
    hostname = "kubernetes";
    architecture = "86x_64-linux";
    packages.allowUnfree = false;
    modules = {

    };
  };
}
