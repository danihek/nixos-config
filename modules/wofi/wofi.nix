{ config, lib, pkgs, ... }:
{
  programs.wofi = {
    enable = true;

    style = ''
      window {
      margin: 0px;
              background-color: #f0e9b2;
              border-radius: 0px;
      border: 8px #242424;
              border-style: double;
      color: #575279;
             font-family: 'unscii';
             font-size: 15px;
            }

      #input {
      margin: 5px;
              border-width: 4px 2px 2px 4px;
              border-radius: 0px;
              border-style: inset;
              border-color: #242424 #f0e9b2 #f0e9b2#242424;
      color: #242424;
             background-color: #f9f5dd;

      }

      #inner-box {
      margin: 5px;
      border: none;
              background-color: #f0e9b2;
      color: #242424;
             border-radius: 0px;
      }

      #outer-box {
      margin: 15px;
      border: none;
              background-color: #f0e9b2;
              border-style: double;
      }

      #scroll {
      margin: 0px;
      border: none;
      }

      #text {
      margin: 5px;
      border: none;
      color: #575279;
      } 

      #entry:selected {
        background-color: #242424;
      color: #242424;
             border-radius: 0px;
      outline: none;

               border-color: #242424;
               border-width: 2px;
               border-style: dotted;
      }

      #entry:selected * {
        background-color: #242424;
      color: #f9f5dd;
             border-radius: 0px;
      border: none;
      margin: none;
      outline: none;
      }
      '';
  };
}
