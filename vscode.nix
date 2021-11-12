{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  programs = {

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim

        # Languages
        bbenoist.Nix
        ms-vscode.cpptools
        ms-python.python
      ];
    };
  };
}
