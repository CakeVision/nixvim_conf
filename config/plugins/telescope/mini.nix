{
  # Mini.nvim modules to support telescope and other plugins
  plugins.mini = {
    enable = true;
    mockDevIcons = true; # Provides icons without needing web-devicons

    modules = {
      # Icons module for file type icons
      icons = {
        style = "glyph"; # "glyph" or "ascii"
      };

      # Other useful mini modules we might want
      pairs = {
        # Autopairs functionality
        mappings = {
          "(" = {
            action = "open";
            pair = "()";
            neigh_pattern = "[^\\].";
          };
          "[" = {
            action = "open";
            pair = "[]";
            neigh_pattern = "[^\\].";
          };
          "{" = {
            action = "open";
            pair = "{}";
            neigh_pattern = "[^\\].";
          };
          ")" = {
            action = "close";
            pair = "()";
            neigh_pattern = "[^\\].";
          };
          "]" = {
            action = "close";
            pair = "[]";
            neigh_pattern = "[^\\].";
          };
          "}" = {
            action = "close";
            pair = "{}";
            neigh_pattern = "[^\\].";
          };
          "\"" = {
            action = "closeopen";
            pair = "\"\"";
            neigh_pattern = "[^\\].";
            register = {cr = false;};
          };
          "'" = {
            action = "closeopen";
            pair = "''";
            neigh_pattern = "[^%a\\].";
            register = {cr = false;};
          };
          "`" = {
            action = "closeopen";
            pair = "``";
            neigh_pattern = "[^\\].";
            register = {cr = false;};
          };
        };
      };

      # Buffer remove without messing up window layout
      bufremove = {};

      # Surround functionality (cs, ds, ys)
      surround = {
        mappings = {
          add = "sa"; # Add surrounding in Normal and Visual modes
          delete = "sd"; # Delete surrounding
          find = "sf"; # Find surrounding (to the right)
          find_left = "sF"; # Find surrounding (to the left)
          highlight = "sh"; # Highlight surrounding
          replace = "sr"; # Replace surrounding
          update_n_lines = "sn"; # Update `n_lines`
        };
      };
    };
  };

  # Keymaps for mini modules
  keymaps = [
    # Buffer deletion
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>lua require('mini.bufremove').delete()<cr>";
      options = {
        desc = "Delete buffer (mini)";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>bD";
      action = "<cmd>lua require('mini.bufremove').delete(0, true)<cr>";
      options = {
        desc = "Force delete buffer";
        silent = true;
      };
    }
  ];
}
