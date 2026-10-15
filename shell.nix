let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-26.05";
  pkgs = import nixpkgs {
    config = { };
    overlays = [ ];
  };
in

pkgs.mkShell {
  packages = with pkgs; [
    gnumake
    git
    openssl
    go
    just
    prettier
    python314
    hugo
  ];

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib ];

  shellHook = ''
    if [ "''${SKIP_VSS_TOOLS:-0}" != "1" ]; then
      python -m venv .venv
      . .venv/bin/activate
      ./scripts/install_vss_tools.sh
    fi
  '';
}
