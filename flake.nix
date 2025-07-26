{
  description = "My Flake";
   
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-colors.url = "github:misterio77/nix-colors";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nyx.url = "https://flakehub.com/f/chaotic-cx/nyx/0.1.2029";

    hyprland-plugins = {
      url = "github:hyprwm/Hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let 
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  in 
  {
    nixosConfigurations = {
      mainNixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };

        modules = [
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.home-manager

          inputs.nix-colors.homeManagerModules.default
          inputs.determinate.nixosModules.default
          inputs.nyx.nixosModules.default
          #inputs.nixvim.homeManagerModules.nixvim
        ];
      };
    };
  };
}
