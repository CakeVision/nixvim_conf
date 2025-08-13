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

      # # Python
      # pyright = {
      #   enable = true;
      #   settings = {
      #     python = {
      #       analysis = {
      #         autoSearchPaths = true;
      #         typeCheckingMode = "standard";
      #         useLibraryCodeForTypes = true;
      #         diagnosticMode = "workspace";
      #       };
      #     };
      #   };
      # };
      ruff = {
        enable = true;
        settings = {
          organizeImports = true;
          fixAll = true;
        };
      };

      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
        settings = {
          # Enable proc-macro support (very important for many Rust projects)
          cargo = {
            buildScripts = {
              enable = true;
            };
            allTargets = true;
            # Load out-of-dir tests for support
            loadOutDirsFromCheck = true;
          };

          # Enable procedural macros
          procMacro = {
            enable = true;
            attributes = {
              enable = true;
            };
          };

          # Check configuration
          checkOnSave = true;
          check = {
            command = "clippy"; # Use clippy instead of just check
            extraArgs = ["--all-targets"]; # Check all targets
            allTargets = true;
          };

          # Completion settings
          completion = {
            addSemicolonToUnit = true;
            autoimport = {
              enable = true;
            };
            callable = {
              snippets = "fill_arguments";
            };
          };

          # Inlay hints (very useful for Rust!)
          inlayHints = {
            enable = true;
            chainingHints = {
              enable = true;
            };
            closingBraceHints = {
              enable = true;
              minLines = 25;
            };
            parameterHints = {
              enable = true;
            };
            typeHints = {
              enable = true;
              hideClosureInitialization = false;
              hideNamedConstructor = false;
            };
            # Show lifetime hints (advanced feature, you can disable if it's too noisy)
            lifetimeElisionHints = {
              enable = "skip_trivial";
              useParameterNames = false;
            };
          };

          # Hover configuration
          hover = {
            actions = {
              enable = true;
              debug = {
                enable = true;
              };
              gotoTypeDef = {
                enable = true;
              };
              implementations = {
                enable = true;
              };
              run = {
                enable = true;
              };
            };
            documentation = {
              enable = true;
              keywords = {
                enable = true;
              };
            };
            memoryLayout = {
              enable = true;
            };
          };

          # Lens (code lenses) - shows things like "Run" and "Debug" above functions
          lens = {
            enable = true;
            debug = {
              enable = true;
            };
            implementations = {
              enable = true;
            };
            references = {
              adt = {
                enable = false; # Can be noisy, enable if you want
              };
              enumVariant = {
                enable = false;
              };
              method = {
                enable = false;
              };
              trait = {
                enable = false;
              };
            };
            run = {
              enable = true;
            };
          };

          # Diagnostics
          diagnostics = {
            enable = true;
            experimental = {
              enable = false; # Enable for bleeding-edge diagnostics
            };
            styleLints = {
              enable = false; # Enable for additional style lints
            };
          };

          # Semantic highlighting
          semanticHighlighting = {
            strings = {
              enable = true;
            };
          };

          # Files configuration
          files = {
            watcher = "notify";
          };
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

    {
      mode = "n";
      key = "<leader>rem";
      action = "<cmd>lua require('telescope.builtin').lsp_document_symbols({ symbols = {'macro'} })<cr>";
      options = {
        desc = "Find macros";
        silent = true;
      };
    }

    # Rust-specific: View HIR
    {
      mode = "n";
      key = "<leader>rh";
      action = "<cmd>lua vim.lsp.buf.execute_command({ command = 'rust-analyzer.viewHir', arguments = { vim.uri_from_bufnr(0), vim.lsp.util.make_position_params().position } })<cr>";
      options = {
        desc = "View HIR";
        silent = true;
      };
    }

    # Rust-specific: Reload workspace
    {
      mode = "n";
      key = "<leader>rr";
      action = "<cmd>lua vim.lsp.buf.execute_command({ command = 'rust-analyzer.reloadWorkspace' })<cr>";
      options = {
        desc = "Reload workspace";
        silent = true;
      };
    }
  ];

  
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

    -- Show diagnostics on hover (but only if there are diagnostics)
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        -- Only show diagnostics popup, not document highlight
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        -- Only open float if there are diagnostics at cursor position
        local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
        if #diagnostics > 0 then
          vim.diagnostic.open_float(nil, opts)
        end
      end
    })

    -- Highlight symbol under cursor (with proper capability checking)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        
        -- Only set up document highlighting if the server supports it
        if client and client.server_capabilities.documentHighlightProvider then
          -- Create a local group for this buffer to avoid conflicts
          local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. bufnr, { clear = true })
          
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            group = group,
            callback = function()
              -- Double check the client is still valid and supports highlighting
              local current_clients = vim.lsp.get_clients({ bufnr = bufnr })
              for _, c in ipairs(current_clients) do
                if c.id == client.id and c.server_capabilities.documentHighlightProvider then
                  vim.lsp.buf.document_highlight()
                  break
                end
              end
            end,
          })
          
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            group = group,
            callback = function()
              vim.lsp.buf.clear_references()
            end,
          })
         vim.api.nvim_create_autocmd("LspAttach", {
              callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client.name == "rust_analyzer" then
                  -- Enable inlay hints for Rust files
                  if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                  end
                  
                  -- Set up Rust-specific keymaps
                  local opts = { buffer = args.buf, silent = true }
                  
                  -- Join lines
                  vim.keymap.set("n", "<leader>rj", function()
                    vim.lsp.buf.execute_command({
                      command = "rust-analyzer.joinLines",
                      arguments = { vim.uri_from_bufnr(0), vim.lsp.util.make_range_params().range }
                    })
                  end, vim.tbl_extend("force", opts, { desc = "Join lines" }))
                  
          -- Structural Search Replace
          vim.keymap.set("n", "<leader>rsr", function()
            local input = vim.fn.input("Search pattern: ")
            if input ~= "" then
              vim.lsp.buf.execute_command({
                command = "rust-analyzer.ssr",
                arguments = { input, vim.uri_from_bufnr(0), vim.lsp.util.make_position_params().position }
              })
            end
          end, vim.tbl_extend("force", opts, { desc = "Structural search replace" }))
        end
      end,
          
          -- Clean up when buffer is deleted
          vim.api.nvim_create_autocmd("BufDelete", {
            buffer = bufnr,
            callback = function()
              vim.api.nvim_del_augroup_by_id(group)
            end,
          })
        end
      end,
    })
  '';
}
