{
  # Basic commenting functionality
  plugins.comment = {
    enable = true;
    settings = {
      # Operator-pending mappings (gcc, gc in visual)
      opleader = {
        line = "gc";
        block = "gb";
      };

      # Extra mappings
      extra = {
        above = "gcO"; # Add comment above
        below = "gco"; # Add comment below
        eol = "gcA"; # Add comment at end of line
      };

      # Enable keybindings
      mappings = {
        basic = true;
        extra = true;
      };
    };
  };

  # Todo comments with custom highlights
  plugins.todo-comments = {
    enable = true;
    settings = {
      # Define custom keywords with colors
      keywords = {
        # Error/Bug related
        FIX = {
          icon = "🔧"; # Wrench
          color = "error";
          alt = ["FIXME" "BUG" "FIXIT" "ISSUE"];
        };

        # Todo items
        TODO = {
          icon = "📋"; # Clipboard
          color = "info";
        };

        # Hacks that need addressing
        HACK = {
          icon = "🔨"; # Hammer
          color = "warning";
        };

        # Warnings
        WARN = {
          icon = "⚠️"; # Warning sign
          color = "warning";
          alt = ["WARNING" "XXX"];
        };

        # Performance related
        PERF = {
          icon = "🚀"; # Rocket
          color = "default";
          alt = ["OPTIM" "PERFORMANCE" "OPTIMIZE"];
        };

        # Notes and important info
        NOTE = {
          icon = "📝"; # Memo
          color = "hint";
          alt = ["INFO"];
        };

        # Testing related
        TEST = {
          icon = "🧪"; # Test tube
          color = "test";
          alt = ["TESTING" "PASSED" "FAILED"];
        };

        # Custom keywords you can add
        REVIEW = {
          icon = "👀"; # Eyes
          color = "#10B981"; # Custom hex color
        };

        QUESTION = {
          icon = "❓"; # Question mark
          color = "#FFB86C";
        };
      };

      # Color definitions
      colors = {
        error = ["DiagnosticError" "ErrorMsg" "#DC2626"];
        warning = ["DiagnosticWarn" "WarningMsg" "#FBBF24"];
        info = ["DiagnosticInfo" "#2563EB"];
        hint = ["DiagnosticHint" "#10B981"];
        default = ["Identifier" "#7C3AED"];
        test = ["Identifier" "#FF00FF"];
      };

      # Search patterns
      search = {
        # Regex that matches keywords
        pattern = "\\b(KEYWORDS):";

        # vim regex or ripgrep regex
        command = "rg";
        args = [
          "--color=never"
          "--no-heading"
          "--with-filename"
          "--line-number"
          "--column"
        ];
      };

      # Highlighting options
      highlight = {
        # Highlight the keyword only, not the whole line
        keyword = "wide"; # "fg", "bg", "wide", "wide_bg", "wide_fg"

        # Highlight after the keyword (the rest of the comment)
        after = "fg"; # "fg", "bg", ""

        # Pattern to match (vim regex)
        pattern = ".*<(KEYWORDS)\\s*:";

        # Enable treesitter highlighting
        comments_only = true;
      };
    };
  };

  # Keymaps for commenting
  keymaps = [
    # Quick toggle comment in normal mode
    {
      mode = "n";
      key = "<C-/>";
      action = "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>";
      options = {
        desc = "Toggle comment";
        silent = true;
      };
    }

    # Toggle comment in visual mode
    {
      mode = "v";
      key = "<C-/>";
      action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>";
      options = {
        desc = "Toggle comment";
        silent = true;
      };
    }

    # Alternative visual mode mapping (more accessible)
    {
      mode = "v";
      key = "<leader>/";
      action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>";
      options = {
        desc = "Toggle comment";
        silent = true;
      };
    }

    # Navigate between todo comments
    {
      mode = "n";
      key = "]t";
      action = "<cmd>lua require('todo-comments').jump_next()<cr>";
      options = {
        desc = "Next todo comment";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "[t";
      action = "<cmd>lua require('todo-comments').jump_prev()<cr>";
      options = {
        desc = "Previous todo comment";
        silent = true;
      };
    }

    # Search todo comments with Telescope (we'll use this later)
    {
      mode = "n";
      key = "<leader>st";
      action = "<cmd>TodoTelescope<cr>";
      options = {
        desc = "Search todos";
        silent = true;
      };
    }

    # Quick todo insertion
    {
      mode = "n";
      key = "<leader>ct";
      action = "O<esc>gccA TODO: 📋 <esc>A";
      options = {
        desc = "Insert TODO comment";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>cf";
      action = "O<esc>gccA FIXME: 🔧 <esc>A";
      options = {
        desc = "Insert FIXME comment";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>cn";
      action = "O<esc>gccA NOTE: 📝 <esc>A";
      options = {
        desc = "Insert NOTE comment";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ch";
      action = "O<esc>gccA HACK: 🔨 <esc>A";
      options = {
        desc = "Insert HACK comment";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>cw";
      action = "O<esc>gccA WARN: ⚠️ <esc>A";
      options = {
        desc = "Insert WARN comment";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>cq";
      action = "O<esc>gccA QUESTION: ❓ <esc>A";
      options = {
        desc = "Insert QUESTION comment";
        silent = true;
      };
    }
  ];
}
