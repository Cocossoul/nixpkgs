{ pkgs, lib, ... }:

{
  home.username = "coco";
  home.homeDirectory = "/home/coco";
  home.packages = [
  ];

  programs.firefox = {
    enable = true;
  };

  programs.home-manager = {
    enable = true;
    path = "…";
  };

  programs.bash = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Corentin PAPE";
    userEmail = "corentin.pape@epita.fr";
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
    };
    plugins = [
      {
        name = "powerlevel10k";
        file = "powerlevel10k.zsh-theme";
        src = pkgs.zsh-powerlevel10k;
      }
    ];
    initExtra = ''
      source "/home/coco/.config/zsh/plugins/powerlevel10k/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
      source "/home/coco/.config/zsh/.p10k.zsh"
   '';
  };

  imports = [
    ./i3.nix
    ./picom.nix
  ];

  home.stateVersion = "21.05";
}
