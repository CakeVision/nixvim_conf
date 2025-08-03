{pkgs, ...}: {
  # Since pymple.nvim is not in nixvim yet, we need to add it as an extra plugin
  extraPlugins = with pkgs.vimPlugins; [
    (pkgs.vimUtils.buildVimPlugin {
      name = "pymple.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "alexpasmantier";
        repo = "pymple.nvim";
        rev = "main"; # You might want to pin this to a specific commit
        sha256 = "sha256-nRMqqQzvwUar58oCt5n29xmy7wICG4vyKjJduxCf1Fc="; # Replace with actual sha256
      };
      # Disable the require check since this plugin has external dependencies
      doCheck = false;

    })
    nui-nvim
  ];

  
   extraConfigLua = ''
    require('pymple').setup({
      -- Enable for Python and Markdown files
      update_imports = {
        filetypes = { "python", "markdown" }
      },
      
      -- Auto-save after adding imports
      add_import_to_buf = {
        autosave = true
      },
      
      -- Python project settings
      python = {
        root_markers = { "pyproject.toml", "setup.py", ".git", "manage.py" },
        virtual_env_names = { ".venv" }
      }
    })
  '';

  # Simple keymaps for the two main functions
  keymaps = [
    # Resolve import under cursor
    {
      mode = "n";
      key = "<leader>pi";
      action.__raw = ''
        function()
          require('pymple.api').resolve_import_under_cursor()
        end
      '';
      options = {
        desc = "Add import for symbol";
        silent = true;
      };
    }
    
    # Update imports after file move/rename
    {
      mode = "n";
      key = "<leader>pu";
      action.__raw = ''
        function()
          -- This would typically be called automatically or with arguments
          -- Just notify the user about the command
          vim.notify("Use :PympleUpdateImports <source> <destination> after moving files", vim.log.levels.INFO)
        end
      '';
      options = {
        desc = "Update imports info";
        silent = true;
      };
    }
  ];
  
  # Ensure ripgrep is available
  extraPackages = with pkgs; [
    ripgrep
    grip-grab
  ];
  
  # Dependencies that pymple.nvim needs
  plugins = {
    # Required dependencies
    telekasten.plenaryPackage.enable = true;
    telescope.enable = true; # Already enabled in your config
    
    # Optional but recommended
    web-devicons.enable = true;
  };
}
