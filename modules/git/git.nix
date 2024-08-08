{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "danihek";
    userEmail = "danihek07@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "libsecret";
    };

    aliases = {
      pu = "push";
      ch = "checkout";
      co = "commit";
    };
  }; 
}
