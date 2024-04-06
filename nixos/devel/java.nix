{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    openjdk17
    maven
    gradle
    lombok
  ];
}
