{ pkgs, ... }:
{
  plugins.none-ls = {
    enable = false;
    enableLspFormat = false;
    updateInInsert = false;
    onAttach = ''
      function(client, bufnr)
          if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { bufnr = bufnr }
              end,
            })
          end
        end
    '';
    sources = {
      code_actions = {
        gitsigns.enable = true;
        statix.enable = true;
      };
      diagnostics = {
        checkstyle = {
          enable = true;
        };
        statix = {
          enable = true;
        };
      };
      formatting = {
# Nix
        alejandra = {
          enable = true;
        };
# Shell
        shfmt = {
          enable = true;
          package = [ pkgs.shfmt ];
        };
# Rust TODO
        rustywind = {
          enable = true;
        };
# Go
        goimports = {
          enable = true;
          package = [ pkgs.gotools ];
        };
        golines = {
          enable = true;
          package = [ pkgs.golines ];
        };
# Yaml
        yamlfmt = {
          enable = true;
          package = [ pkgs.yamlfmt ];
        };
# Various
        prettier = {
          enable = true;
          package = [ pkgs.prettier ];
          disableTsServerFormatter = true;
          withArgs = ''
            {
              extra_args = { "--no-semi", "--single-quote" },
            }
          '';
        };
# Java
        google_java_format = {
          enable = true;
          package = [ pkgs.google-java-format ];
        };
# Lua
        stylua = {
          enable = true;
          package = [ pkgs.stylua ];
        };
# Pythont
        black = {
          enable = true;
          #package = with pkgs; [ python3.12-black ];
          withArgs = ''
            {
              extra_args = { "--fast" },
            }
          '';
        };
      };
    };
  };
  # keymaps = [
  #   {
  #     mode = [ "n" "v" ];
  #     key = "<leader>cf";
  #     action = "<cmd>lua vim.lsp.buf.format()<cr>";
  #     options = {
  #       silent = true;
  #       desc = "Format";
  #     };
  #   }
  # ];
}
