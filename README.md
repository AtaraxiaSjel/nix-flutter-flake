# nix-flutter-flake

Developer environment for the Flutter engine using nix flakes.

Automatically creates a development shell with Flutter, supporting Android, Linux, and web projects.

This project is based on:

* [flake-parts](https://github.com/hercules-ci/flake-parts)
* [devshell](https://github.com/numtide/devshell)
* [android-nixpkgs](https://github.com/tadfisher/android-nixpkgs)

## Using

Clone this project and enter the development shell using the ```nix develop``` command.
Alternatively, if you are using direnv, allow it to enter the shell with the ```direnv allow``` command.

If you would like to use Android Studio, add "pkgs.android-studio" to the packages option in [flake.nix](./flake.nix).
