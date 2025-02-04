{pkgs, ...}: {
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["jack"];
  virtualisation.virtualbox.guest.enable = true;
}
