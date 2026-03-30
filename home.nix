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

	home.stateVersion = "25.11";
}
