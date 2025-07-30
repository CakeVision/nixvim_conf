{
   
  # Global variables
  globals = {
    mapleader = " ";
    maplocalleader = ",";
  };

  # Neovim options

  opts = {
    # Line numbers
    number = true;
    relativenumber = true;

    # Tabs and indentation
    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;
    smartindent = true;

    # UI
    termguicolors = true;
    signcolumn = "yes";
    cursorline = true;
    scrolloff = 8;
    sidescrolloff = 8;
    wrap = false;

    # Search
    ignorecase = true;
    smartcase = true;
    hlsearch = true;
    incsearch = true;

    # Splits
    splitbelow = true;
    splitright = true;

    # Misc
    updatetime = 50;
    timeoutlen = 300;
    backup = false;
    swapfile = false;
    undofile = true;

    # Better completion experience
    completeopt = "menuone,noselect,noinsert";
  };

  # Clipboard support
  clipboard = {
    register = "unnamedplus";
  };
}
