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

<<<<<<< HEAD
=======
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
                        include = "/home/lily/.config/kitty/Kaolin Ocean.conf";
                };
        };

>>>>>>> 53b3e05 (Kitty configuration)
	home.stateVersion = "25.11";
}
