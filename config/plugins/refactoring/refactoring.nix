{
  plugins.refactoring = {
    enable = true;
    
    # Enable prompt for renaming
    settings = {
      prompt_func_return_type = {
        go = true;
        cpp = true;
        c = true;
        java = true;
        python = true;
      };
      
      prompt_func_param_type = {
        go = true;
        cpp = true;
        c = true;
        java = true;
        python = true;
      };
      
      # Show success messages
      show_success_message = true;
    };
  };

  # Keymaps for refactoring operations
  keymaps = [
    # Extract function (visual mode)
    {
      mode = "v";
      key = "<leader>re";
      action.__raw = ''
        function()
          require('refactoring').refactor('Extract Function')
        end
      '';
      options = {
        desc = "Extract function";
        silent = true;
      };
    }
    
    # Extract function to file (visual mode)
    {
      mode = "v";
      key = "<leader>rf";
      action.__raw = ''
        function()
          require('refactoring').refactor('Extract Function To File')
        end
      '';
      options = {
        desc = "Extract function to file";
        silent = true;
      };
    }
    
    # Extract variable (visual mode)
    {
      mode = "v";
      key = "<leader>rv";
      action.__raw = ''
        function()
          require('refactoring').refactor('Extract Variable')
        end
      '';
      options = {
        desc = "Extract variable";
        silent = true;
      };
    }
    
    # Inline variable (visual and normal mode)
    {
      mode = ["n" "v"];
      key = "<leader>ri";
      action.__raw = ''
        function()
          require('refactoring').refactor('Inline Variable')
        end
      '';
      options = {
        desc = "Inline variable";
        silent = true;
      };
    }
    
    # Extract block (visual mode)
    {
      mode = "v";
      key = "<leader>rb";
      action.__raw = ''
        function()
          require('refactoring').refactor('Extract Block')
        end
      '';
      options = {
        desc = "Extract block";
        silent = true;
      };
    }
    
    # Extract block to file (visual mode)
    {
      mode = "v";
      key = "<leader>rbf";
      action.__raw = ''
        function()
          require('refactoring').refactor('Extract Block To File')
        end
      '';
      options = {
        desc = "Extract block to file";
        silent = true;
      };
    }
    
    # Refactoring menu using Telescope
    {
      mode = ["n" "v"];
      key = "<leader>rr";
      action = "<cmd>Telescope refactoring refactors<cr>";
      options = {
        desc = "Refactoring menu";
        silent = true;
      };
    }
    
    # Debug operations
    {
      mode = "n";
      key = "<leader>rp";
      action.__raw = ''
        function()
          require('refactoring').debug.printf({below = false})
        end
      '';
      options = {
        desc = "Debug print";
        silent = true;
      };
    }
    
    {
      mode = "v";
      key = "<leader>rdv";
      action.__raw = ''
        function()
          require('refactoring').debug.print_var()
        end
      '';
      options = {
        desc = "Debug print variable";
        silent = true;
      };
    }
    
    {
      mode = "n";
      key = "<leader>rdc";
      action.__raw = ''
        function()
          require('refactoring').debug.cleanup({})
        end
      '';
      options = {
        desc = "Debug cleanup";
        silent = true;
      };
    }
  ];
}
