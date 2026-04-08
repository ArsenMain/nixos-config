{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        luaConfigPost = ''
          vim.api.nvim_create_autocmd("TextYankPost", {
            desc = "Highlight when yanking (copying) text",
            callback = function()
              vim.highlight.on_yank()
            end,

          })
        '';

        options = {
          wrap = false;
          autoindent = true;
        };

        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.wl-copy.enable = true;
        };

        autocomplete.blink-cmp = {
          enable = true;
          setupOpts.sources.default = [
            "lsp"
            "snippets"
          ];
          mappings = {
            #confirm = "<Tab>"; # maybe I'm stupid?
            #next = "<down>";
            #previous = "<up>";
          };
        };
        lsp = {
          enable = true;
          inlayHints.enable = true;
          trouble.enable = true;
          servers = {
            "*" = {
              root_markers = [ ".git" ];
              capabilities = {
                textDocument = {
                  semanticTokens = {
                    multilineTokenSupport = true;
                  };
                };
              };
            };
          };
        };
        languages = {
          enableTreesitter = true;
          nix = {
            enable = true;
            lsp.enable = true;
            extraDiagnostics.enable = true;
            format = {
              enable = true;
              # TODO
              type = [ "nixfmt" ]; # Currently seems to fuck up tab spacing (or however you want to call it)
            };
          };

          rust = {
            enable = true;
            lsp.enable = true;
          };
        };
        statusline.lualine = {
          enable = true;
          icons.enable = true;
          theme = "gruvbox_dark";
          activeSection = {
            a = [
              ''
                { 
                        "mode", 
                        icons_enabled = true, 
                        separator = { right = '' }, 
                }
              ''
              ''
                { 
                        "", 
                        draw_empty = true, 
                        separator = { 
                                        left = '', 
                                        right = '' 
                                    } 
                }
              ''
            ];
          };
        };
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };
        utility = {
          oil-nvim = {
            enable = true;
            gitStatus.enable = true;
          };
        };
        filetree.nvimTree = {
          enable = true;
          openOnSetup = true; # needs to be set true rn to work -> why?
        };
        visuals = {
          nvim-web-devicons.enable = true;
        };
        keymaps = [
          {
            key = "F";
            mode = "n";
            silent = true;
            action = ":NvimTreeOpen<ENTER>";
          }
        ];
      };
>>>>>>> 62e48f6 (stuff. kinda forgot)
    };
  };
}
