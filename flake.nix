{
  description = "My Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    remote-nvim = {
      url = "github:amitds1997/remote-nvim.nvim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    remote-nvim,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSystem = nixpkgs.lib.genAttrs systems;
  in {
    packages = forEachSystem (system: {
      default = nixvim.legacyPackages.${system}.makeNixvimWithModule {
        pkgs = nixpkgs.legacyPackages.${system};
        module = {
          imports = [./config];
          _module.args = {inherit remote-nvim; };
        };
      };
    });
  };
}
