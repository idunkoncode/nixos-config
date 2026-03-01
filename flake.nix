{
  description = "Qtile on NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware-specific modules (ThinkPad X1 Carbon 6th gen, etc.)
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # System-wide theming (base16 / Catppuccin)
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NvChad neovim distribution
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin wallpapers (flake = false → no sha256 needed, pinned via lock)
    catppuccin-wallpapers = {
      url   = "github:zhichaoh/catppuccin-wallpapers";
      flake = false;
    };

    # Doom Emacs packaged with Nix (bypasses straight.el)
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "";  # uses its own nixpkgs for reproducibility
    };
  };

  outputs = { nixpkgs, home-manager, nixos-hardware, stylix, ... }@inputs:
  let
    system = "x86_64-linux";

    mkHome = homeFile: {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs; };
      home-manager.users.itsthicc = import homeFile;
    };
  in
  {
    nixosConfigurations = {

      nixos-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          stylix.nixosModules.stylix
          ./hosts/host1/configuration.nix
          ./nixosModules
          home-manager.nixosModules.home-manager
          (mkHome ./hosts/host1/home.nix)
        ];
      };

      nixos-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          stylix.nixosModules.stylix
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-carbon-6th
          ./hosts/host2/configuration.nix
          ./nixosModules
          ./nixosModules/laptop.nix
          home-manager.nixosModules.home-manager
          (mkHome ./hosts/host2/home.nix)
        ];
      };

    };
  };
}
