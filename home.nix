{ ... }:

{
  nixpkgs.config.allowUnfree = true;
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
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
    };
  };

  imports = [
    ./i3.nix
    ./picom.nix
    ./zsh.nix
    ./vim.nix
    ./vscode.nix
  ];

  home.stateVersion = "21.05";
}
