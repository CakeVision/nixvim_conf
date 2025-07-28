{
  plugins.oil = {
    enable = true;
    settings = {
      # Oil will take over netrw
      default_file_explorer = true;

      # Columns to show
      columns = ["icon"];

      # Buffer-local options
      buf_options = {
        buflisted = false;
        bufhidden = "hide";
      };

      # Window-local options
      win_options = {
        wrap = false;
        signcolumn = "no";
        cursorcolumn = false;
        foldcolumn = "0";
        spell = false;
        list = false;
        conceallevel = 3;
        concealcursor = "nvic";
      };

      # Send deleted files to trash instead of permanently deleting
      delete_to_trash = true;

      # Skip confirmation for simple operations
      skip_confirm_for_simple_edits = false;

      # Selecting a new/moved/renamed file will prompt you to save changes first
      prompt_save_on_select_new_entry = true;

      # Keymaps in oil buffer. Can be a string or function
      keymaps = {
        "g?" = "actions.show_help";
        "<CR>" = "actions.select";
        "<C-v>" = "actions.select_vsplit";
        "<C-h>" = "actions.select_split";
        "<C-t>" = "actions.select_tab";
        "<C-p>" = "actions.preview";
        "<C-c>" = "actions.close";
        "<C-l>" = "actions.refresh";
        "-" = "actions.parent";
        "_" = "actions.open_cwd";
        "`" = "actions.cd";
        "~" = "actions.tcd";
        "gs" = "actions.change_sort";
        "gx" = "actions.open_external";
        "g." = "actions.toggle_hidden";
        "g\\" = "actions.toggle_trash";
      };

      # Use default keymaps
      use_default_keymaps = true;

      view_options = {
        # Show hidden files by default
        show_hidden = false;
      };
    };
  };
}
