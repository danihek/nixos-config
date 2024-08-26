{
  # Work in progress MPD service
  services.mpd = {
    enable = true;
    extraConfig = ''
      audio_output {
          type            "httpd"
          name            "My HTTP Stream"
          encoder         "vorbis"
          port            "8000"
          bind_to_address "0.0.0.0"
          quality         "5.0"
          format          "44100:16:2"
      }
    '';
  };
}
