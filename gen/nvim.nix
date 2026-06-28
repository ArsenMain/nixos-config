{ ... }: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        autocmds = [
          {
            enable = true;
            event = [ "BufEnter" ];
            pattern = [ "*" ];
            command = "setlocal indentexpr=nvim_treesitter#indent()";
          }
          {
            enable = true;
            event = [ "VimEnter" ];
            pattern = [ "*" ];
            command = ":NvimTreeClose";
          }
        ];

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
          tabstop = 4;
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
            confirm = "<Tab>";
            next = "<DOWN>";
            previous = "<UP>";
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
              type = [ "nixfmt" ];
            };
          };

          rust = {
            enable = true;
            lsp.enable = true;
            format.enable = true;
          };
          typescript = {
            enable = true;
            lsp.enable = true;
            format.enable = true;
          };
          python = {
            enable = true;
            lsp.enable = true;
            format.enable = true;
          };
          clang = {
            enable = true;
            lsp.enable = true;
          };
          css = {
            enable = true;
            lsp.enable = true;
            format.enable = true;
          };
          html = {
            enable = true;
            lsp.enable = true;
            format.enable = true;
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
        diagnostics = {
          enable = true;
          config = {
            #virtual_lines = true;
            virtual_text = true;
          };
        };
        keymaps = [
          {
            key = "F";
            mode = "n";
            silent = true;
            action = ":NvimTreeOpen<ENTER>";
          }
          {
            key = "T";
            mode = "n";
            silent = true;
            action = ":NvimTreeClose<ENTER>";
          }
          {
            key = "E";
            mode = "n";
            silent = true;
            action = "$";
          }
          {
            key = "B";
            mode = "n";
            silent = true;
            action = "0";
          }
        ];
      };
    };
  };
}
