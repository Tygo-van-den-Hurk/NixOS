# Docker
Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infrastructure in the same ways you manage your applications. By taking advantage of Docker's methodologies for shipping, testing, and deploying code, you can significantly reduce the delay between writing code and running it in production.

## Module Type
The type of this module is `user`, as a user needs to be added to the `docker` group. That's why the user needs to enable this module within their settings.

## Module Settings
These are all the settings a user can have for the docker module:
```NIX
users.${username}.init.modules.docker = {
    enable = boolean; # if not explicitly true, then this module will never be loaded for this user.
}
```
