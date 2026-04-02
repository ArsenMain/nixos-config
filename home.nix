{ pkgs, ... }: {
	# nvim
	/*programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;

	};*/

	# git
	programs.git = {
		enable = true;
		settings.user = {
			name = "ArsenMain";
			email = "doriyahganonbusted@gmail.com";
		};
	};

        # kitty
        programs.kitty = {
                enable = true;
                settings = {
                        confirm_os_window_close = 0;
                        enable_audio_bell = false;
                        mouse_hide_wait = "-1.0";
                        font-family = "NotoMono Nerd Font";
                        scrollback_lines = 5000;
                        remember_window_size = "no";
                        initial_window_width = 800;
                        initial_window_height = 400;
                        linux_display_server = "x11";
                        tab_bar_style = "powerline";
                        include = "/etc/nixos/resources/Kaolin Ocean.conf";
                };
        };

        programs.vscode = {
          enable = true;
          package = pkgs.vscodium;
          profiles.default.extensions = with pkgs.vscode-extensions; [
            dracula-theme.theme-dracula
            vscodevim.vim
            yzhang.markdown-all-in-one
          ];
        };

	home.stateVersion = "25.11";
}
