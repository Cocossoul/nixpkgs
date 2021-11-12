{ pkgs, ... }:

{
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
      eval $(ssh-agent) > /dev/null
      set -o vi
   '';
  };
}
