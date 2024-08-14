{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host server 
      HostName 192.168.1.200
      User b1

      Host pc
      HostName 192.168.1.195
      User dh

      Host laptop
      HostName 192.168.1.190
      User ven

      Host phone
      HostName 192.168.1.185
      User u0_a315
      Port 8022
    '';
  };
}
