{
  plugins.remote-nvim = {
    enable = true;
    
    settings = {
      # Progress notifications
      progress_view = {
        type = "popup";
      };
      
      neovim_install = {
        copy_dirs = {
          config = {
            enabled = false;
          };
          data = {
            enabled = false;
          };
        };
      }; 
    };
  };

  # Simple keymaps
  keymaps = [
    {
      mode = "n";
      key = "<leader>rmc";
      action = "<cmd>RemoteStart<cr>";
      options = {
        desc = "Connect to remote";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>rms";
      action = "<cmd>RemoteStop<cr>";
      options = {
        desc = "Stop remote session";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>rmi";
      action = "<cmd>RemoteInfo<cr>";
      options = {
        desc = "Remote info";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>rml";
      action = "<cmd>RemoteLog<cr>";
      options = {
        desc = "Remote log";
        silent = true;
      };
    }
  ];
}
