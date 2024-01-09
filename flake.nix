{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    arion.url = "github:hercules-ci/arion";
    config-graphql-schema.url = "github:chadac/test-nixspace-config-graphql-schema";
  };

  outputs = { self, flake-parts, systems, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;

      flake = {
        lib = {
          arionModule = { pkgs, ... }: let
            inherit (pkgs) system bash;
            inherit (self.packages.${system}) rest-api;
          in {
            services.gql-api = {
              service.image = "nixos/nix:latest";
              service.useHostStore = true;
              service.command = ["${bash}/bin/bash" "-c" "${rest-api}/bin/rest-api"];
              service.ports = ["8000:8001"];
            };
          };
        };
      };
      perSystem = { pkgs, system, ... }: let
        inherit (pkgs) python3;
        package = pkgs.callPackage ./default.nix { };
      in {
        packages = rec {
          inherit package;
        };
        devShells.default = pkgs.mkShell {
          # packages = with pkgs; [ nodejs ];
          inputsFrom = [ package ];
          shellHook = ''
          '';
        };
      };
    };
}
