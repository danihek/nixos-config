{ pkgs, ... }:

let
  shyFox = pkgs.fetchFromGitHub {
    owner = "danihek";
    repo = "ShyFox";
    rev = "master";
    src = ./.;
  };
  
  firefoxProfilePath = "${pkgs.mozilla.firefox}/share/firefox/profiles/default-release";
in

pkgs.stdenv.mkDerivation {
  pname = "shyfox-firefox-profile";
  version = "1.0";

  buildInputs = [ pkgs.makeWrapper ];

  buildPhase = ''
    # Create the profile directory if it doesn't exist
    mkdir -p "${firefoxProfilePath}/chrome"
    
    # Copy the chrome folder
    cp -r ${shyFox}/chrome/* "${firefoxProfilePath}/chrome/"
    
    # Copy the user.js file
    cp ${shyFox}/user.js "${firefoxProfilePath}/"
  '';

  installPhase = ''
    echo "Files have been copied to ${firefoxProfilePath}."
  '';

  meta = with pkgs.stdenv.lib; {
    description = "Copy ShyFox configuration files to Firefox profile";
    license = licenses.mit;
    maintainers = with maintainers; [ yourMaintainerName ];
  };
}
