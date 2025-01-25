{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (spotify.overrideAttrs ({postInstall ? "", ...}: {
      postInstall =
        postInstall
        + ''
          sed -i "s:^Exec=\(.*\):Exec=\1 --enable-features=UseOzonePlatform --ozone-platform=wayland:" "$out/share/applications/spotify.desktop"
        '';
    }))
  ];
}
