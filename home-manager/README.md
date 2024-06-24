# Home-Manager
This directory contains a bunch of people's dot files. Here you can add your own dot files submodule, and then that would load. When doing a `nixos-rebuild switch`.

## Adding your own
If you want to add your own sub-module, then you can follow the following steps to get up and running:

```BASH
git submodule add https://domain.com/username/repo.git home-manager/your-name/
```
then run 
```BASH
git submodule update --init --recursive
```
to make sure that it's loaded.

<!-- TODO add more steps to get it up and running... -->
