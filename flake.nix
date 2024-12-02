{
  description = "My Flake";
   
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
   
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    erosanix = {
      url = "github:emmanuelrosa/erosanix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
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
          ./nixos/configuration.nix
          #inputs.nixvim.homeManagerModules.nixvim
	  #inputs.erosanix.nixosModules.protonvpn
        ];
      };
    };
  };
}
