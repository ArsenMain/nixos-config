{ ... }:
{
  home-manager.users.lily.programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      font_family = "NotoMono Nerd Font";
      scrollback_lines = 5000;
      remember_window_size = "no";
      initial_window_width = 800;
      initial_window_height = 400;
      linux_display_server = "wayland";
      tab_bar_style = "powerline";
      #include = "~/.config/nixos-config/resources/Kaolin Ocean.conf";
      repaint_delay = 5;
      # All following configs are taken over from the Kaolin Ocean theme
      foreground = "#e6e6e8";
      background = "#14141e";
      selection_foreground = "#14141e";
      selection_background = "#e6e6e8";
      cursor = "#e6e6e8";
      cursor_text_color = "#14141e";
      active_border_color = "#6bd9db";
      inactive_border_color = "#545c5e";
      active_tab_background = "#e6e6e8";
      active_tab_foreground = "#14141e";
      inactive_tab_background = "#545c5e";
      inactive_tab_foreground = "#14141e";
      color0 = "#14141e";
      color8 = "#545c5e";
      color1 = "#e84c58";
      color9 = "#e84c58";
      color2 = "#35BF88";
      color10 = "#7CF083";
      color3 = "#dbac66";
      color11 = "#eed891";
      color4 = "#4ca6e8";
      color12 = "#53859d";
      color5 = "#c79af4";
      color13 = "#cea2ca";
      color6 = "#6bd9db";
      color14 = "#4d9391";
      color7 = "#e6e6e8";
      color15 = "#bebec4";
    };
  };
}
