{
  pkgs,
  config,
  ...
}: {
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  environment.systemPackages = [
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        waveform
        obs-tuna
        obs-websocket
        obs-webkitgtk
        obs-text-pthread
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    })
  ];
}
