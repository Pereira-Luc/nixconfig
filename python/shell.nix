{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python3
    pkgs.python3Packages.pip
    pkgs.python3Packages.pyautogui
    pkgs.python3Packages.keyboard
  ];

  shellHook = ''
    echo "Python and required packages are installed."
  '';
}

