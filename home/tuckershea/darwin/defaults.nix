# System and app configuration via `defaults`
{
  targets.darwin.defaults = {
    "com.apple.TextEdit" = {
      AddExtensionToNewPlainTextFiles = false;
      RichText = false;
      CheckSpellingAsYouTypeEnabledInRichTextOnly = true;
    };

    "com.apple.dock" = {
      autohide = false;
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
  };
}
