{
  description = "System configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
  }: let
    system = "x86_64-linux";

    lib = nixpkgs.lib;

    pkgs = import nixpkgs {
      system = system;
      config.allowUnfree = true;
    };
    unstable = import nixpkgs-unstable {
      system = system;
      config.allowUnfree = true;
    };

    userSettings = {
      username = "jack";
      longname = "Jack Morrison";
      email = "jackamorr@gmail.com";
      dotfilesDir = "~/config-git";
    };
  in {
    nixosConfigurations = {
      spectre = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./configs/spectre/configuration.nix];
        specialArgs = {
          inherit pkgs;
          inherit unstable;
          inherit userSettings;
        };
      };
    };
  };
}
