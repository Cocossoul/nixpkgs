{ ... }:

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

  imports = [
    ./i3.nix
    ./picom.nix
    ./zsh.nix
    ./vim.nix
  ];

  home.stateVersion = "21.05";
}
