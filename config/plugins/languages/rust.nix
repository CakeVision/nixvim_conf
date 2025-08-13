{pkgs, ...}: {
  # Additional Rust-specific plugins that work well with rust-analyzer
  plugins = {
    # Crates.nvim for Cargo.toml management
    crates-nvim = {
      enable = true;
      settings = {
        # Show popup with crate information
        popup = {
          autofocus = true;
          border = "rounded";
        };
        # Enable null-ls integration
        null_ls = {
          enabled = true;
          name = "crates.nvim";
        };
      };
    };

    # Optional: rustaceanvim (advanced Rust tooling)
    # Note: This is a more advanced plugin that might conflict with basic rust-analyzer setup
    # Uncomment if you want advanced features like debugging, etc.
    # rustaceanvim = {
    #   enable = true;
    #   settings = {
    #     tools = {
    #       hover_actions = {
    #         auto_focus = true;
    #       };
    #     };
    #   };
    # };
  };

  # Additional Rust-specific keymaps
  keymaps = [
    # Crates.nvim keymaps (for Cargo.toml files)
    {
      mode = "n";
      key = "<leader>rct";
      action = "<cmd>lua require('crates').toggle()<cr>";
      options = {
        desc = "Toggle crates.nvim";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>rcr";
      action = "<cmd>lua require('crates').reload()<cr>";
      options = {
        desc = "Reload crates";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>rcv";
      action = "<cmd>lua require('crates').show_versions_popup()<cr>";
      options = {
        desc = "Show versions";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>rcf";
      action = "<cmd>lua require('crates').show_features_popup()<cr>";
      options = {
        desc = "Show features";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>rcd";
      action = "<cmd>lua require('crates').show_dependencies_popup()<cr>";
      options = {
        desc = "Show dependencies";
        silent = true;
      };
    }

    # Quick Cargo commands
    {
      mode = "n";
      key = "<leader>rcc";
      action = "<cmd>!cargo check<cr>";
      options = {
        desc = "Cargo check";
        silent = false;
      };
    }
    {
      mode = "n";
      key = "<leader>rcb";
      action = "<cmd>!cargo build<cr>";
      options = {
        desc = "Cargo build";
        silent = false;
      };
    }
    {
      mode = "n";
      key = "<leader>rct";
      action = "<cmd>!cargo test<cr>";
      options = {
        desc = "Cargo test";
        silent = false;
      };
    }
    {
      mode = "n";
      key = "<leader>rcr";
      action = "<cmd>!cargo run<cr>";
      options = {
        desc = "Cargo run";
        silent = false;
      };
    }
  ];

  # Auto-commands for Rust files
  autoCmd = [
    # Auto-format Rust files on save
    {
      event = ["BufWritePre"];
      pattern = ["*.rs"];
      callback = {
        __raw = ''
          function()
            vim.lsp.buf.format({ async = false })
          end
        '';
      };
    }
    
    # Set specific options for Rust files
    {
      event = ["FileType"];
      pattern = ["rust"];
      callback = {
        __raw = ''
          function()
            -- Set indentation to 4 spaces for Rust (common convention)
            vim.opt_local.shiftwidth = 4
            vim.opt_local.tabstop = 4
            vim.opt_local.softtabstop = 4
            
            -- Enable word wrap at 100 characters (common in Rust)
            vim.opt_local.textwidth = 100
            vim.opt_local.colorcolumn = "100"
          end
        '';
      };
    }
  ];
}
