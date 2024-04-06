{...}: {
  # Enable and configure sound
  sound.enable = true;
  security.rtkit.enable = true; # Optional but recommended by wiki
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
