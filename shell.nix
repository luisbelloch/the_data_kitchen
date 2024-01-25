{ pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  packages = [
    pkgs.curl
    pkgs.coreutils
    pkgs.python311
    pkgs.pandoc
  ];
}

