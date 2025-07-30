{
  keymaps = [
    # Quick escape
    {
      mode = "i";
      key = "jk";
      action = "<ESC>";
      options = {
        silent = true;
      };
    }
    #TODO: change me
    # Window navigation(maybe not, it is really comfy :/)
    # Deal with it future me 
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options.desc = "Go to left window";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options.desc = "Go to lower window";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options.desc = "Go to upper window";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options.desc = "Go to right window";
    }

    # Resize windows with arrows
    {
      mode = "n";
      key = "<C-Up>";
      action = ":resize -2<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = ":resize +2<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = ":vertical resize -2<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = ":vertical resize +2<CR>";
      options.silent = true;
    }

    # Buffer navigation
    {
      mode = "n";
      key = "[b";
      action = ":bprevious<CR>";
      options = {
        silent = true;
        desc = "Previous buffer";
      };
    }
    {
      mode = "n";
      key = "]b";
      action = ":bnext<CR>";
      options = {
        silent = true;
        desc = "Next buffer";
      };
    }

    # Quick save
    {
      mode = ["n" "i" "v"];
      key = "<C-s>";
      action = "<cmd>w<cr><esc>";
      options = {
        desc = "Save file";
        silent = true;
      };
    }

    # Clear search highlight
    {
      mode = "n";
      key = "<leader>h";
      action = ":nohl<CR>";
      options = {
        desc = "Clear search highlight";
        silent = true;
      };
    }

    # Better indenting in visual mode
    {
      mode = "v";
      key = "<";
      action = "<gv";
      options = {
        desc = "Indent left";
      };
    }
    {
      mode = "v";
      key = ">";
      action = ">gv";
      options = {
        desc = "Indent right";
      };
    }

    # Move text up and down
    {
      mode = "n";
      key = "<A-j>";
      action = ":m .+1<CR>==";
      options = {
        desc = "Move line down";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<A-k>";
      action = ":m .-2<CR>==";
      options = {
        desc = "Move line up";
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<A-j>";
      action = ":m '>+1<CR>gv=gv";
      options = {
        desc = "Move selection down";
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<A-k>";
      action = ":m '<-2<CR>gv=gv";
      options = {
        desc = "Move selection up";
        silent = true;
      };
    }
  ];
}
