{pkgs, ...}: {
  plugins.telescope = {
    enable = true;

    # Telescope extensions
    extensions = {
      fzf-native = {
        enable = true;
      };
      ui-select = {
        enable = true;
        settings = {
          specific_opts = {
            codeactions = true;
          };
        };
      };
      undo = {
        enable = true;
      };
    };

    settings = {
      defaults = {
        prompt_prefix = "🔍 ";
        selection_caret = "▶ ";
        entry_prefix = "  ";

        initial_mode = "insert";
        selection_strategy = "reset";
        sorting_strategy = "ascending";

        layout_strategy = "flex";
        layout_config = {
          horizontal = {
            prompt_position = "top";
            preview_width = 0.55;
            results_width = 0.8;
          };
          vertical = {
            mirror = false;
          };
          width = 0.87;
          height = 0.80;
          preview_cutoff = 120;
        };

        file_ignore_patterns = [
          "node_modules"
          ".git/"
          "dist/"
          "build/"
          "target/" # Rust
          "__pycache__/"
          "*.pyc"
          ".venv/"
          "vendor/" # Go
        ];

        path_display = ["truncate"];
        winblend = 0;

        border = true;
        borderchars = ["─" "│" "─" "│" "╭" "╮" "╯" "╰"];

        color_devicons = true;
        use_less = true;
        set_env = {
          COLORTERM = "truecolor";
        };

        file_previewer = "require('telescope.previewers').vim_buffer_cat.new";
        grep_previewer = "require('telescope.previewers').vim_buffer_vimgrep.new";
        qflist_previewer = "require('telescope.previewers').vim_buffer_qflist.new";

        # Developer configurations
        buffer_previewer_maker = "require('telescope.previewers').buffer_previewer_maker";

        mappings = {
          i = {
            "<C-n>" = "move_selection_next";
            "<C-p>" = "move_selection_previous";
            "<C-c>" = "close";
            "<Down>" = "move_selection_next";
            "<Up>" = "move_selection_previous";
            "<CR>" = "select_default";
            "<C-x>" = "select_horizontal";
            "<C-v>" = "select_vertical";
            "<C-t>" = "select_tab";
            "<C-u>" = "preview_scrolling_up";
            "<C-d>" = "preview_scrolling_down";
            "<C-q>" = "send_to_qflist + open_qflist";
            "<M-q>" = "send_selected_to_qflist + open_qflist";
            "<Tab>" = "toggle_selection + move_selection_worse";
            "<S-Tab>" = "toggle_selection + move_selection_better";
            "<C-l>" = "complete_tag";
            "<C-_>" = "which_key";
          };
          n = {
            "<esc>" = "close";
            "<CR>" = "select_default";
            "<C-x>" = "select_horizontal";
            "<C-v>" = "select_vertical";
            "<C-t>" = "select_tab";
            "<Tab>" = "toggle_selection + move_selection_worse";
            "<S-Tab>" = "toggle_selection + move_selection_better";
            "<C-q>" = "send_to_qflist + open_qflist";
            "<M-q>" = "send_selected_to_qflist + open_qflist";
            "j" = "move_selection_next";
            "k" = "move_selection_previous";
            "H" = "move_to_top";
            "M" = "move_to_middle";
            "L" = "move_to_bottom";
            "<Down>" = "move_selection_next";
            "<Up>" = "move_selection_previous";
            "gg" = "move_to_top";
            "G" = "move_to_bottom";
            "<C-u>" = "preview_scrolling_up";
            "<C-d>" = "preview_scrolling_down";
            "?" = "which_key";
          };
        };
      };

      pickers = {
        find_files = {
          theme = "dropdown";
          previewer = false;
          find_command = ["rg" "--files" "--hidden" "--glob" "!.git/*"];
        };
        live_grep = {
          theme = "ivy";
        };
        buffers = {
          theme = "dropdown";
          previewer = false;
          initial_mode = "normal";
        };
        current_buffer_fuzzy_find = {
          theme = "dropdown";
          previewer = false;
        };
        oldfiles = {
          theme = "dropdown";
          previewer = false;
        };
        command_history = {
          theme = "dropdown";
        };
      };
    };
  };

  # Keymaps for Telescope
  keymaps = [
    # File pickers
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
      options = {
        desc = "Find files";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>fd";
      action.__raw = ''
        function()
          require('telescope.builtin').find_files({
            prompt_title = "Find Directories",
            find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
            previewer = false,
            theme = "dropdown",
          })
        end
      '';
      options = {
        desc = "Find directories";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope git_files<cr>";
      options = {
        desc = "Find git files";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "<cmd>Telescope oldfiles<cr>";
      options = {
        desc = "Recent files";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<cr>";
      options = {
        desc = "Find buffers";
        silent = true;
      };
    }

    # Search pickers
    {
      mode = "n";
      key = "<leader>sg";
      action = "<cmd>Telescope live_grep<cr>";
      options = {
        desc = "Grep search";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>sw";
      action = "<cmd>Telescope grep_string<cr>";
      options = {
        desc = "Search word under cursor";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>sc";
      action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
      options = {
        desc = "Search current buffer";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>sh";
      action = "<cmd>Telescope help_tags<cr>";
      options = {
        desc = "Search help";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>sm";
      action = "<cmd>Telescope man_pages<cr>";
      options = {
        desc = "Search man pages";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>sk";
      action = "<cmd>Telescope keymaps<cr>";
      options = {
        desc = "Search keymaps";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>sc";
      action = "<cmd>Telescope commands<cr>";
      options = {
        desc = "Search commands";
        silent = true;
      };
    }

    # LSP pickers
    {
      mode = "n";
      key = "<leader>ls";
      action = "<cmd>Telescope lsp_document_symbols<cr>";
      options = {
        desc = "Document symbols";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>lS";
      action = "<cmd>Telescope lsp_workspace_symbols<cr>";
      options = {
        desc = "Workspace symbols";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ld";
      action = "<cmd>Telescope diagnostics<cr>";
      options = {
        desc = "Diagnostics";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "gr";
      action = "<cmd>Telescope lsp_references<cr>";
      options = {
        desc = "LSP references";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "gI";
      action = "<cmd>Telescope lsp_implementations<cr>";
      options = {
        desc = "LSP implementations";
        silent = true;
      };
    }

    # Git pickers
    {
      mode = "n";
      key = "<leader>gc";
      action = "<cmd>Telescope git_commits<cr>";
      options = {
        desc = "Git commits";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gC";
      action = "<cmd>Telescope git_bcommits<cr>";
      options = {
        desc = "Git buffer commits";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "<cmd>Telescope git_branches<cr>";
      options = {
        desc = "Git branches";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gs";
      action = "<cmd>Telescope git_status<cr>";
      options = {
        desc = "Git status";
        silent = true;
      };
    }

    # Other pickers
    {
      mode = "n";
      key = "<leader>su";
      action = "<cmd>Telescope undo<cr>";
      options = {
        desc = "Undo tree";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader><leader>";
      action = "<cmd>Telescope resume<cr>";
      options = {
        desc = "Resume last search";
        silent = true;
      };
    }

    # Quick access
    {
      mode = "n";
      key = "<C-p>";
      action = "<cmd>Telescope find_files<cr>";
      options = {
        desc = "Find files";
        silent = true;
      };
    }

    # Quick access lists
    {
      mode = "n";
      key = "<leader>qd";
      action.__raw = ''
        function()
          -- Find directories and send to quickfix
          require('telescope.builtin').find_files({
            prompt_title = "Directories → Quickfix",
            find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
            previewer = false,
            theme = "ivy",
            attach_mappings = function(_, map)
              map('i', '<CR>', function(prompt_bufnr)
                local actions = require('telescope.actions')
                actions.send_to_qflist(prompt_bufnr)
                actions.open_qflist(prompt_bufnr)
              end)
              return true
            end,
          })
        end
      '';
      options = {
        desc = "Directories to quickfix";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>qt";
      action.__raw = ''
        function()
          -- Find TODOs and send to quickfix
          require('telescope.builtin').grep_string({
            prompt_title = "TODOs → Quickfix",
            search = "\\b(TODO|FIXME|HACK|WARN|PERF|NOTE|TEST|REVIEW|QUESTION):",
            use_regex = true,
            theme = "ivy",
            initial_mode = "normal",
            attach_mappings = function(_, map)
              map('n', '<CR>', function(prompt_bufnr)
                local actions = require('telescope.actions')
                actions.send_to_qflist(prompt_bufnr)
                actions.open_qflist(prompt_bufnr)
              end)
              map('i', '<CR>', function(prompt_bufnr)
                local actions = require('telescope.actions')
                actions.send_to_qflist(prompt_bufnr)
                actions.open_qflist(prompt_bufnr)
              end)
              return true
            end,
          })
        end
      '';
      options = {
        desc = "TODOs to quickfix";
        silent = true;
      };
    }

    # Quickfix navigation
    {
      mode = "n";
      key = "[q";
      action = "<cmd>cprevious<cr>";
      options = {
        desc = "Previous quickfix";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "]q";
      action = "<cmd>cnext<cr>";
      options = {
        desc = "Next quickfix";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>qo";
      action = "<cmd>copen<cr>";
      options = {
        desc = "Open quickfix";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>qc";
      action = "<cmd>cclose<cr>";
      options = {
        desc = "Close quickfix";
        silent = true;
      };
    }
  ];

  # Extra packages
  extraPackages = with pkgs; [
    ripgrep # For better searching
    fd # Alternative to find
  ];
}
