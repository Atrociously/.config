{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    openjdk17
    openjdk21
    maven
    gradle
    lombok
  ];
}
