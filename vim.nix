{ pkgs, lib, ... }:
{
  programs.vim = {
    enable = true;

    # vimrc
    extraConfig = builtins.concatStringsSep "\n" [
       (lib.strings.fileContents ./config.vim)
    ];

    plugins = with pkgs.vimPlugins; [
      # vim theme
      vim-airline
    ];
  };
}
