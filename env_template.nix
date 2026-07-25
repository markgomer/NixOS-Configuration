{
  description = "Dev environment and build template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # --- BUILD PROCEDURE ---
        # Run: `nix build`
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "my-project"; # Name package
          version = "0.1.0";    # Set version

          src = ./.; # Source code dir

          # Build-time tools (compilers, make, cmake)
          nativeBuildInputs = with pkgs; [
            # gcc
            # make
          ];

          # Runtime libs needed at build time
          buildInputs = with pkgs; [
            # openssl
          ];

          # Build commands. If Makefile exist, standard `make` run auto.
          # Manual build steps here:
          buildPhase = ''
            # e.g., make build
          '';

          # Install binary/artifacts to $out output path
          installPhase = ''
            mkdir -p $out/bin
            # cp my-binary $out/bin/
          '';
        };

        # --- DEV ENVIRONMENT ---
        # Run: `nix develop`
        devShells.default = pkgs.mkShell {
          # Tools available in dev shell
          packages = with pkgs; [
            # git
            # ripgrep
            # language-server
          ];

          # load shared objects at runtime
          LD_LIBRARY_PATH =
            pkgs.lib.makeLibraryPath [
              # pkgs.alsa-lib
              # pkgs.libGL
            ];


          # Shell hook run on enter `nix develop`
          shellHook = ''
            echo "Dev shell active!"
            # export MY_ENV_VAR="value"
          '';
        };
      }
    );
}
