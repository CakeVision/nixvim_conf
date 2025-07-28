{
  plugins.which-key = {
    enable = true;

    settings = {
      # Delay before showing the popup (in ms)
      delay = 500;

      # Configure which-key display
      preset = "modern"; # "classic", "modern", or "helix"

      # Replace keycodes (<CR> -> <Enter>, <BS> -> <Backspace>, etc.)
      replace = {
        desc = [
          ["<space>" "SPACE"]
          ["<leader>" "SPACE"]
          ["<[cC][rR]>" "ENTER"]
          ["<[tT][aA][bB]>" "TAB"]
          ["<[bB][sS]>" "BACKSPACE"]
        ];
      };

      # Icons for different kinds of keymaps
      icons = {
        breadcrumb = "»";
        separator = "➜";
        group = "+";
      };

      # Window configuration
      win = {
        border = "rounded"; # none, single, double, rounded, solid, shadow
        padding = [1 2]; # top/bottom, left/right
      };

      # Layout configuration
      layout = {
        spacing = 3;
        align = "left"; # left, center, right
      };
    };

    # Register keymap groups
    # This is where we define the '+' prefixes you see in which-key
    registrations = {
      # Leader mappings
      "<leader>b" = "+buffers";
      "<leader>c" = "+code";
      "<leader>f" = "+find";
      "<leader>g" = "+git";
      "<leader>l" = "+lsp";
      "<leader>s" = "+search";
      "<leader>t" = "+toggle";
      "<leader>w" = "+windows";
      "<leader>x" = "+diagnostics";

      # Other prefix mappings
      "g" = "+goto";
      "]" = "+next";
      "[" = "+prev";
      "z" = "+fold";
    };
  };

  # Additional keymaps that integrate with which-key
  # These will automatically show up in the which-key popup
  keymaps = [
    # Buffer mappings
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>bdelete<cr>";
      options = {
        desc = "Delete buffer";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>bn";
      action = "<cmd>bnext<cr>";
      options = {
        desc = "Next buffer";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>bprevious<cr>";
      options = {
        desc = "Previous buffer";
        silent = true;
      };
    }

    # Window mappings
    {
      mode = "n";
      key = "<leader>wv";
      action = "<C-w>v";
      options = {
        desc = "Split vertical";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ws";
      action = "<C-w>s";
      options = {
        desc = "Split horizontal";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>wc";
      action = "<C-w>c";
      options = {
        desc = "Close window";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>wo";
      action = "<C-w>o";
      options = {
        desc = "Only window";
        silent = true;
      };
    }

    # Toggle mappings
    {
      mode = "n";
      key = "<leader>tn";
      action = "<cmd>set relativenumber!<cr>";
      options = {
        desc = "Toggle relative numbers";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>tw";
      action = "<cmd>set wrap!<cr>";
      options = {
        desc = "Toggle wrap";
        silent = true;
      };
    }
  ];
}
