let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-26.05";
  pkgs = import nixpkgs {
    config = { };
    overlays = [ ];
  };
in

pkgs.mkShell {
  packages = with pkgs; [
    just
    prettier
    python314
  ];

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib ];

  shellHook = ''
    python -m venv .venv
    . .venv/bin/activate
    ./scripts/install_vss_tools.sh
  '';
}
