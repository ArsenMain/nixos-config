{ pkgs, ... }: {
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

            
            autocomplete.blink-cmp = {
                enable = true;
                setupOpts.sources.default = [
                   "lsp"
                   "snippets"
                ];
            };
            lsp = {
               enable = true;
               inlayHints.enable = true;
               trouble.enable = true;
               servers = {
                "*" = {
                   root_markers = [".git"];
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
                nix = {
                   enable = true;
                   lsp.enable = true;
                };

                rust = {
                   enable = true;
                   lsp.enable = true;
                };
            };
            theme = {
                enable = true;
                name = "gruvbox";
                style = "dark";
            };
            startPlugins = [
                pkgs.vimPlugins.nvim-tree-lua
                #"nvim-tree-lua"
            ];
         };
    };
  };
}
