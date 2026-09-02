{
  programs.ssh = {
    enableAskPassword = false;
    extraConfig = ''
      Host home
        User git
        HostName github.com
        IdentityFile ~/.ssh/id_ed25519
      Host school
        User git
        HostName github.com
        IdentityFile ~/.ssh/formica
    '';
  };
}
