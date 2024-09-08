{
  # Font smoothing makes text seem bolder, this allows
  # for thinner looking fonts on retina displays.
  # e.g. https://www.reddit.com/r/MacOS/comments/16tow2w/psa_turn_off_font_smoothing/
  # This is especially important for Alacritty which
  # does not render correctly otherwise, but boy does
  # it look nice everywhere else too.
  system.defaults.NSGlobalDomain.AppleFontSmoothing = 0;
}
