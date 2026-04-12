{ pkgs, inputs, ... }:
{
  home-manager.users.lily = {
    # import the home manager module
    imports = [
      inputs.noctalia.homeModules.default
    ];

    # configure options
    programs.noctalia-shell = {
      enable = true;
    };

    # niri 
    programs.niri = {
        #package = pkgs.niri;
        settings = {
        spawn-at-startup = [
                {
                        command = [
                                "noctalia-shell"
                        ];
                }
        ];
        };
    };
  };
}
