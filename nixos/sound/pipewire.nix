{pkgs, ...}: {
  # Enable and configure sound
  security.rtkit.enable = true; # Optional but recommended by wiki

  # Add pipewire gui patchbay / audio config
  environment.systemPackages = with pkgs; [
    alsa-utils
    pavucontrol
    helvum
  ];

  hardware.alsa.enablePersistence = true;

  # Enable pipewire service with pulse enabled
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
