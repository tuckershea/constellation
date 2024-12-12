# System and app configuration via `defaults`
# Large inspiration from https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236
{
  targets.darwin.defaults = {
    NSGlobalDomain = {
      # Add a context menu item for showing the Web Inspector in web views
      WebKitDeveloperExtras = true;
    };
    "com.apple.desktopservices" = {
      # Avoid creating .DS_Store files on network or USB volumes
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
    "com.apple.dock" = {
      autohide = true;
      mineffect = "suck";
      orientation = "bottom";
      show-recent-count = 1;
      show-recents = true;
      showAppExposeGestureEnabled = true;
      size-immutable = true;
      tilesize = 48;
      wvous-bl-corner = 11;
      wvous-br-corner = 14;
      wvous-tl-corner = 5;
      wvous-tr-corner = 2;
    };
    "com.apple.finder" = {
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = true;
      ShowMountedServersOnDesktop = true;
      ShowRemovableMediaOnDesktop = true;
      _FXSortFoldersFirst = true;
      # When performing a search, search the current folder by default
      FXDefaultSearchScope = "SCcf";
    };
    "com.apple.screencapture" = {
      location = "~/Pictures/Screenshots";
      type = "png";
    };
    "com.apple.screensaver" = {
      # Require password immediately after sleep or screen saver begins
      askForPassword = 1;
      askForPasswordDelay = 0;
    };
    "com.apple.SoftwareUpdate" = {
      AutomaticCheckEnabled = true;
      # Check for software updates daily, not just once per week
      ScheduleFrequency = 1;
      # Download newly available updates in background
      AutomaticDownload = 1;
      # Install System data files & security updates
      CriticalUpdateInstall = 1;
    };
    "com.apple.TextEdit" = {
      AddExtensionToNewPlainTextFiles = false;
      RichText = false;
      CheckSpellingAsYouTypeEnabledInRichTextOnly = true;
    };
  };
}
