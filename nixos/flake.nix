{
  description = "System configuration flake";

  inputs = {
    fenix-pkgs = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    fenix-pkgs,
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

    fenix = fenix-pkgs.packages.${system};

    config = name:
      lib.nixosSystem {
        system = system;
        modules = [(./. + "/configs/${name}/configuration.nix")];
        specialArgs = {
          inherit pkgs;
          inherit unstable;
          inherit userSettings;
          inherit fenix;
        };
      };
  in {
    packages.${system}.default = fenix.stable.toolchain;
    nixosConfigurations = {
      spectre = config "spectre";
      invicta = config "invicta";
    };
  };
}
