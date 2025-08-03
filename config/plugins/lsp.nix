{pkgs, ...}: {
  plugins.lsp = {
    enable = true;

    # Keymaps that will be set when LSP attaches to a buffer
    keymaps = {
      # Diagnostics navigation
      diagnostic = {
        "[d" = "goto_prev";
        "]d" = "goto_next";
        "<leader>ld" = "open_float";
      };

      # LSP actions
      lspBuf = {
        "gd" = "definition";
        "gD" = "declaration";
        "gi" = "implementation";
        "gt" = "type_definition";
        "gr" = "references";
        "K" = "hover";
        "<leader>lr" = "rename";
        "<leader>la" = "code_action";
        "<leader>lf" = "format";
      };
    };

    # Language servers configuration
    servers = {
      # Go
      gopls = {
        enable = true;
        settings = {
          gopls = {
            analyses = {
              unusedparams = true;
              unusedvariable = true;
              unusedwrite = true;
              useany = true;
            };
            experimentalPostfixCompletions = true;
            gofumpt = true;
            staticcheck = true;
            usePlaceholders = true;
            hints = {
              assignVariableTypes = true;
              compositeLiteralFields = true;
              compositeLiteralTypes = true;
              constantValues = true;
              functionTypeParameters = true;
              parameterNames = true;
              rangeVariableTypes = true;
            };
          };
        };
      };

      # Python
      pyright = {
        enable = true;
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true;
              typeCheckingMode = "standard";
              useLibraryCodeForTypes = true;
              diagnosticMode = "workspace";
            };
          };
        };
      };
      ruff = {
        enable = true;
        settings = {
          organizeImports = true;
          fixAll = true;
        };
      };

      # Alternative Python LSP (uncomment if you prefer this over pyright)
      # pylsp = {
      #   enable = true;
      #   settings = {
      #     pylsp = {
      #       plugins = {
      #         pycodestyle = {
      #           enabled = true;
      #           maxLineLength = 100;
      #         };
      #         pyflakes.enabled = true;
      #         pylint.enabled = true;
      #         autopep8.enabled = true;
      #         yapf.enabled = false;
      #         black.enabled = true;
      #       };
      #     };
      #   };
      # };

      # Nix - using nixd instead of nil
      nixd = {
        enable = true;
        settings = {
          nixd = {
            formatting = {
              command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
            };
            options = {
              # You can specify your flake here for better completion
              nixos = {
                expr = ''(builtins.getFlake "github:NixOS/nixpkgs/nixos-unstable").nixosConfigurations.example.options'';
              };
              home_manager = {
                expr = ''(builtins.getFlake "github:nix-community/home-manager").homeConfigurations.example.options'';
              };
            };
          };
        };
      };

      # Lua (for Neovim config)
      lua_ls = {
        enable = true;
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT";
            };
            diagnostics = {
              globals = ["vim"];
            };
            workspace = {
              library = [
                "\${3rd}/luv/library"
              ];
              checkThirdParty = false;
            };
            telemetry = {
              enable = false;
            };
            format = {
              enable = true;
              defaultConfig = {
                indent_style = "space";
                indent_size = "2";
              };
            };
          };
        };
      };

      # Markdown
      marksman = {
        enable = true;
      };

      # YAML
      yamlls = {
        enable = true;
      };

      # JSON
      jsonls = {
        enable = true;
      };

      # Bash
      bashls = {
        enable = true;
      };
    };
  };

  # Extra packages needed for LSP functionality
  extraPackages = with pkgs; [
    # Go tools
    go
    gopls
    gofumpt
    gotools
    go-tools
    golangci-lint
    delve # Go debugger

    # Python tools
    python3
    pyright
    black
    isort
    mypy
    ruff

    # Nix tools
    nixd
    nixpkgs-fmt
    statix

    # Lua tools
    lua-language-server
    stylua

    # General tools
    marksman # Markdown LSP
    yaml-language-server
    nodePackages.vscode-langservers-extracted # JSON, HTML, CSS
    nodePackages.bash-language-server
  ];

  # Additional keymaps for LSP features
  keymaps = [
    # Show line diagnostics
    {
      mode = "n";
      key = "<leader>le";
      action = "<cmd>lua vim.diagnostic.open_float()<cr>";
      options = {
        desc = "Line diagnostics";
        silent = true;
      };
    }

    # Quick fix
    {
      mode = "n";
      key = "<leader>lq";
      action = "<cmd>lua vim.diagnostic.setloclist()<cr>";
      options = {
        desc = "Quickfix diagnostics";
        silent = true;
      };
    }

    # Code action menu (alternative binding)
    {
      mode = ["n" "v"];
      key = "<leader>ca";
      action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
      options = {
        desc = "Code action";
        silent = true;
      };
    }

    # Format buffer
    {
      mode = "n";
      key = "<leader>cf";
      action = "<cmd>lua vim.lsp.buf.format({ async = true })<cr>";
      options = {
        desc = "Format buffer";
        silent = true;
      };
    }

    # Restart LSP
    {
      mode = "n";
      key = "<leader>lR";
      action = "<cmd>LspRestart<cr>";
      options = {
        desc = "Restart LSP";
        silent = true;
      };
    }

    # LSP info
    {
      mode = "n";
      key = "<leader>li";
      action = "<cmd>LspInfo<cr>";
      options = {
        desc = "LSP info";
        silent = true;
      };
    }
     {
      mode = "n";
      key = "<leader>co";
      action = "<cmd>PyrightOrganizeImports<cr>";
      options = {
        desc = "Organize imports (Python)";
        silent = true;
      };
    }
     {
      mode = "n";
      key = "<leader>lo";
      action.__raw = ''
        function()
          if vim.bo.filetype == "python" then
            vim.cmd("PyrightOrganizeImports")
          else
            vim.notify("Organize imports not available for " .. vim.bo.filetype, vim.log.levels.INFO)
          end
        end
      '';
      options = {
        desc = "Organize imports";
        silent = true;
      };
    }
  ];

  # Custom Lua configuration for LSP
  extraConfigLua = ''
    -- Customize diagnostic signs using the modern API
    local signs = { Error = "✘", Warn = "▲", Hint = "⚡", Info = "ℹ" }

    -- Configure diagnostics with signs and other settings
    vim.diagnostic.config({
      virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR },
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = signs.Error,
          [vim.diagnostic.severity.WARN] = signs.Warn,
          [vim.diagnostic.severity.HINT] = signs.Hint,
          [vim.diagnostic.severity.INFO] = signs.Info,
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = 'rounded',
        source = true,
      },
    })

    -- Show diagnostics on hover
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end
    })

    -- Highlight symbol under cursor
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = args.buf,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = args.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })
  '';
}
