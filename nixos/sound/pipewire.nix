{pkgs, ...}: {
  # Enable and configure sound
  sound.enable = true;
  security.rtkit.enable = true; # Optional but recommended by wiki

  # Add pipewire gui patchbay / audio config
  environment.systemPackages = with pkgs; [
    pavucontrol
    helvum
  ];

  # Enable pipewire service with pulse enabled
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
