{ pkgs, ... }:

let
  shyFox = pkgs.fetchFromGitHub {
    owner = "danihek";
    repo = "ShyFox";
    rev = "master"; # Use a specific commit hash if needed
    src = ./.; # Assumes you run from within the cloned directory
  };

  # Specify the path to your Firefox profile
  firefoxProfilePath = "${pkgs.mozilla.firefox}/share/firefox/profiles/default-release"; # Adjust if your profile name is different
in

# Define a derivation to copy the files
pkgs.stdenv.mkDerivation {
  pname = "shyfox-firefox-profile";
  version = "1.0";

  # Build inputs
  buildInputs = [ pkgs.makeWrapper ];

  # Build phase
  buildPhase = ''
    # Create the profile directory if it doesn't exist
    mkdir -p "${firefoxProfilePath}/chrome"
    
    # Copy the chrome folder
    cp -r ${shyFox}/chrome/* "${firefoxProfilePath}/chrome/"
    
    # Copy the user.js file
    cp ${shyFox}/user.js "${firefoxProfilePath}/"
  '';

  # Install phase (no installation needed)
  installPhase = ''
    echo "Files have been copied to ${firefoxProfilePath}."
  '';

  # No outputs, we only copy files
  meta = with pkgs.stdenv.lib; {
    description = "Copy ShyFox configuration files to Firefox profile";
    license = licenses.mit;  # Adjust license as needed
    maintainers = with maintainers; [ yourMaintainerName ];  # Optional
  };
}
