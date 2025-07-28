{pkgs, ...}: {
  plugins.treesitter = {
    enable = true;

    # Grammar packages to install
    nixGrammars = true;

    # Treesitter settings
    settings = {
      # Treesitter-based features
      highlight = {
        enable = true;
        additional_vim_regex_highlighting = false;
      };

      indent = {
        enable = true;
      };

      # Incremental selection (expand selection with repeated key presses)
      incremental_selection = {
        enable = true;
        keymaps = {
          init_selection = "<CR>"; # Start selection
          node_incremental = "<CR>"; # Increment to next node
          node_decremental = "<BS>"; # Decrement to previous node
          scope_incremental = "<TAB>"; # Increment to next scope
        };
      };
    };
  };

  # Treesitter text objects for better code navigation
  plugins.treesitter-textobjects = {
    enable = true;

    select = {
      enable = true;
      lookahead = true; # Automatically jump forward to textobj

      keymaps = {
        # You can use the capture groups defined in textobjects.scm
        "af" = "@function.outer";
        "if" = "@function.inner";
        "ac" = "@class.outer";
        "ic" = "@class.inner";
        "aa" = "@parameter.outer";
        "ia" = "@parameter.inner";
        "ab" = "@block.outer";
        "ib" = "@block.inner";
      };
    };

    move = {
      enable = true;
      setJumps = true; # whether to set jumps in the jumplist

      gotoNextStart = {
        "]m" = "@function.outer";
        "]]" = "@class.outer";
        "]a" = "@parameter.inner";
      };

      gotoNextEnd = {
        "]M" = "@function.outer";
        "][" = "@class.outer";
      };

      gotoPreviousStart = {
        "[m" = "@function.outer";
        "[[" = "@class.outer";
        "[a" = "@parameter.inner";
      };

      gotoPreviousEnd = {
        "[M" = "@function.outer";
        "[]" = "@class.outer";
      };
    };

    swap = {
      enable = true;
      swapNext = {
        "<leader>sn" = "@parameter.inner";
      };
      swapPrevious = {
        "<leader>sp" = "@parameter.inner";
      };
    };
  };

  # Context - shows current function/class at top of buffer
  plugins.treesitter-context = {
    enable = true;
    settings = {
      enable = true;
      max_lines = 3; # How many lines the context should show
      min_window_height = 0;
      line_numbers = true;
      multiline_threshold = 20;
      trim_scope = "outer";
      mode = "cursor"; # cursor or topline
      separator = "─"; # Can be nil for no separator
    };
  };

  # Additional keymaps for treesitter features
  keymaps = [
    # Visual mode: select around/inside function
    {
      mode = "v";
      key = "af";
      action = "<cmd>TSTextobjectSelect @function.outer<cr>";
      options = {
        desc = "Select around function";
        silent = true;
      };
    }
    {
      mode = "v";
      key = "if";
      action = "<cmd>TSTextobjectSelect @function.inner<cr>";
      options = {
        desc = "Select inside function";
        silent = true;
      };
    }

    # Quick navigation
    {
      mode = "n";
      key = "<leader>ss";
      action = "<cmd>TSHighlightCapturesUnderCursor<cr>";
      options = {
        desc = "Show syntax group under cursor";
        silent = true;
      };
    }
  ];
}
