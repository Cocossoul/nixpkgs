{ config, lib, pkgs, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
  };
}
