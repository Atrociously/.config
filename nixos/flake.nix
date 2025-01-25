{
  description = "System configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    rose-pine-hyprcursor,
  }: let
    system = "x86_64-linux";

    lib = nixpkgs.lib;

    stable = import nixpkgs-stable {
      system = system;
      config.allowUnfree = true;
    };

    userSettings = {
      username = "jack";
      longname = "Jack Morrison";
      email = "jackamorr@gmail.com";
      dotfilesDir = "~/config-git";
    };

    config = name:
      lib.nixosSystem {
        system = system;
        modules = [(./. + "/configs/${name}/configuration.nix")];
        specialArgs = {
          inherit stable;
          inherit userSettings;
          inherit rose-pine-hyprcursor;
        };
      };
  in {
    nixosConfigurations = {
      spectre = config "spectre";
      invicta = config "invicta";
    };
  };
}
