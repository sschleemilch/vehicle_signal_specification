{
  sources ? import ./npins,
  system ? builtins.currentSystem,
  pkgs ? import sources.nixpkgs {
    inherit system;
    config = { };
    overlays = [ ];
  },
}:

pkgs.mkShell {
  packages = with pkgs; [
    git
    openssl
    go
    just
    prettier
    python314
    uv
    hugo
  ];

  UV_PYTHON_DOWNLOADS = "never";
  UV_PYTHON = "${pkgs.python314}/bin/python3";

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib ];

  shellHook = ''
    export PATH="$HOME/.local/bin:$PATH"
    alias install-vss-tools="uv tool install -U git+https://github.com/COVESA/vss-tools@master"
  '';
}
