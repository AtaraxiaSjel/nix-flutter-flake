{
  description = "Flutter dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    android-nixpkgs.url = "github:tadfisher/android-nixpkgs/stable";
    android-nixpkgs.inputs.nixpkgs.follows = "nixpkgs";
    android-nixpkgs.inputs.devshell.follows = "devshell";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devshell.flakeModule ];
      systems = [ "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: rec {
        packages.android-sdk = inputs.android-nixpkgs.sdk.${system} (sdkPkgs:
          with sdkPkgs; [
            cmdline-tools-latest
            build-tools-30-0-3
            platform-tools
            platforms-android-33
            patcher-v4
            emulator
          ]);
        devshells.default = {
          env = [
            {
              name = "PATH";
              prefix = "$HOME/.pub-cache/bin";
            }
            {
              name = "ANDROID_HOME";
              value = "${packages.android-sdk}/share/android-sdk";
            }
            {
              name = "ANDROID_SDK_ROOT";
              value = "${packages.android-sdk}/share/android-sdk";
            }
            {
              name = "JAVA_HOME";
              value = pkgs.jdk.home;
            }
            {
              name = "CHROME_EXECUTABLE";
              value = "${pkgs.ungoogled-chromium}/bin/chromium";
            }
          ];
          packages = [ pkgs.flutter pkgs.jdk pkgs.gradle packages.android-sdk ];
        };
      };
    };
}
