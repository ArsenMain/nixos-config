{ ... }: {
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      open = "xdg-open";
    };
    promptInit = ''
      PS1="┌──\[\e[32m\][\u@\h: \w]\n\[\e[0m\]└─\[\e[32m\]▪\[\e[0m\] "
    '';
  };
}
