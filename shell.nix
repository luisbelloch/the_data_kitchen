{ pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  packages = [
    pkgs.aspell
    pkgs.aspellDicts.en
    pkgs.curl
    pkgs.coreutils
    pkgs.python311
    pkgs.pandoc
    pkgs.slides
  ];
}

