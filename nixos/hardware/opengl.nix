{...}: {
  # Setup opengl to be enabled
  # this is for hardware acceleration
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
