{ pkgs, ... }:

{
  home.packages = [
    pkgs.starship
  ];

  programs.starship = {
    enable = true;
  
    settings = {
      continuation_prompt = "[▸▹ ](dimmed white)";
      character = {
        success_symbol = "➜";
        error_symbol = "♿";
      };
  
     git_branch.symbol = "🌱 ";
     git_commit.tag_disabled = false;
     git_status = {
       ahead = ''⇡''${count}'';
       behind = ''⇣''${count}'';
       diverged = ''⇕⇡''${ahead_count}⇣''${behind_count}'';
       staged = "+$count";
     };
  
     nix_shell = {
       format = "via [$symbol$state]($style) ";
       impure_msg = "ι";
       pure_msg = "﻿ρ";
       symbol = "❄️";
     };
  
    };
  };
  }
