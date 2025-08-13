{
  # Enhanced Python LSP to work with direnv and shell.nix
  plugins.lsp.servers.pyright.settings.python = {
    analysis = {
      autoSearchPaths = true;
      typeCheckingMode = "standard";
      useLibraryCodeForTypes = true;
      diagnosticMode = "workspace";
      # Use python from current environment (direnv will set this)
      pythonPath = "python3";
    };
    # Auto-detect virtual environments
    venvPath = ".";
    venv = ["venv" ".venv" "env" ".env"];
  };

  # Direnv integration with enhanced shell.nix support
  extraConfigLua = ''
    -- Function to reload LSP clients (using modern API)
    local function reload_lsp()
      local clients = vim.lsp.get_clients()
      for _, client in ipairs(clients) do
        if client.name == "pyright" or client.name == "pylsp" then
          vim.cmd("LspRestart " .. client.name)
        end
      end
    end

    -- Function to check and load direnv environment
    local function load_direnv()
      local handle = io.popen("direnv status 2>/dev/null")
      if handle then
        local result = handle:read("*a")
        handle:close()
        
        -- Check if we have shell.nix or .envrc file
        local has_shell_nix = vim.fn.filereadable("shell.nix") == 1
        local has_envrc = vim.fn.filereadable(".envrc") == 1
        
        if has_shell_nix or has_envrc then
          -- Export direnv environment to current Neovim session
          local env_handle = io.popen("direnv export json 2>/dev/null")
          if env_handle then
            local env_json = env_handle:read("*a")
            env_handle:close()
            
            if env_json and env_json ~= "" then
              -- Parse JSON manually (basic implementation)
              -- This handles the most common environment variables
              for key, value in env_json:gmatch('"([^"]+)":"([^"]*)"') do
                -- Set important environment variables
                if key == "PATH" or 
                   key == "PYTHONPATH" or 
                   key:match("^PYTHON") or 
                   key == "VIRTUAL_ENV" or
                   key:match("^MONITOR_") or -- Your custom vars
                   key == "PROMETHEUS_PORT" or
                   key == "LOG_LEVEL" then
                  vim.fn.setenv(key, value)
                end
              end
              
              -- Show notification about loaded environment
              if has_shell_nix then
                vim.notify("shell.nix environment loaded", vim.log.levels.INFO)
              end
            end
          end
        end
      end
    end

    -- Function to manually create .envrc if it doesn't exist
    local function setup_envrc()
      if vim.fn.filereadable("shell.nix") == 1 and vim.fn.filereadable(".envrc") == 0 then
        local envrc_content = "use nix\n"
        local file = io.open(".envrc", "w")
        if file then
          file:write(envrc_content)
          file:close()
          vim.notify("Created .envrc file. Run ':DirenvAllow' to activate.", vim.log.levels.INFO)
        end
      end
    end

    -- Auto-reload when relevant files change
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = {
        ".envrc", 
        "shell.nix", 
        "flake.nix", 
        "pyproject.toml", 
        "requirements.txt",
        "requirements-dev.txt",
        "setup.py",
        "Pipfile"
      },
      callback = function()
        local filename = vim.fn.expand("%:t")
        vim.notify("Environment file (" .. filename .. ") changed, reloading LSP...", vim.log.levels.INFO)
        vim.defer_fn(function()
          load_direnv()
          reload_lsp()
        end, 100)
      end,
    })

    -- Load direnv when changing directories
    vim.api.nvim_create_autocmd("DirChanged", {
      callback = function()
        vim.defer_fn(function()
          load_direnv()
          reload_lsp()
        end, 100)
      end,
    })

    -- Load direnv when entering Python files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {"python", "nix"},
      callback = function()
        load_direnv()
      end,
    })

    -- Load direnv on startup if we're in a project directory
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        setup_envrc() -- Auto-create .envrc if needed
        load_direnv()
      end,
    })

    -- Enhanced function to manually reload environment
    _G.reload_dev_environment = function()
      load_direnv()
      reload_lsp()
      
      -- Show current Python interpreter
      local python_path = vim.fn.exepath("python3")
      if python_path ~= "" then
        vim.notify("Development environment reloaded!\nPython: " .. python_path, vim.log.levels.INFO)
      else
        vim.notify("Development environment reloaded!", vim.log.levels.INFO)
      end
    end

    -- Function to show current environment info
    _G.show_dev_env_info = function()
      local info = {}
      
      -- Python info
      local python_path = vim.fn.exepath("python3")
      if python_path ~= "" then
        table.insert(info, "Python: " .. python_path)
      end
      
      -- Environment variables
      local pythonpath = os.getenv("PYTHONPATH")
      if pythonpath then
        table.insert(info, "PYTHONPATH: " .. pythonpath)
      end
      
      local virtual_env = os.getenv("VIRTUAL_ENV")
      if virtual_env then
        table.insert(info, "VIRTUAL_ENV: " .. virtual_env)
      end
      
      -- Your custom environment variables
      local monitor_config = os.getenv("MONITOR_CONFIG_PATH")
      if monitor_config then
        table.insert(info, "MONITOR_CONFIG_PATH: " .. monitor_config)
      end
      
      local prometheus_port = os.getenv("PROMETHEUS_PORT")
      if prometheus_port then
        table.insert(info, "PROMETHEUS_PORT: " .. prometheus_port)
      end
      
      local log_level = os.getenv("LOG_LEVEL")
      if log_level then
        table.insert(info, "LOG_LEVEL: " .. log_level)
      end
      
      if #info > 0 then
        vim.notify("Development Environment Info:\n" .. table.concat(info, "\n"), vim.log.levels.INFO)
      else
        vim.notify("No development environment detected", vim.log.levels.WARN)
      end
    end

    -- Function to check if direnv is working
    _G.check_direnv_status = function()
      local handle = io.popen("direnv status 2>&1")
      if handle then
        local result = handle:read("*a")
        handle:close()
        vim.notify("Direnv Status:\n" .. result, vim.log.levels.INFO)
      else
        vim.notify("Could not check direnv status", vim.log.levels.ERROR)
      end
    end
  '';

  # Enhanced keymaps for direnv management
  keymaps = [
    {
      mode = "n";
      key = "<leader>de";
      action = "<cmd>!direnv allow<cr><cmd>lua _G.reload_dev_environment()<cr>";
      options = {
        desc = "Allow direnv and reload";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dr";
      action = "<cmd>lua _G.reload_dev_environment()<cr>";
      options = {
        desc = "Reload dev environment";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ds";
      action = "<cmd>lua _G.check_direnv_status()<cr>";
      options = {
        desc = "Show direnv status";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dd";
      action = "<cmd>!direnv deny<cr>";
      options = {
        desc = "Deny direnv";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>di";
      action = "<cmd>lua _G.show_dev_env_info()<cr>";
      options = {
        desc = "Show dev environment info";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dc";
      action.__raw = ''
        function()
          -- Create .envrc if shell.nix exists but .envrc doesn't
          if vim.fn.filereadable("shell.nix") == 1 and vim.fn.filereadable(".envrc") == 0 then
            local envrc_content = "use nix\n"
            local file = io.open(".envrc", "w")
            if file then
              file:write(envrc_content)
              file:close()
              vim.notify("Created .envrc file", vim.log.levels.INFO)
            else
              vim.notify("Failed to create .envrc file", vim.log.levels.ERROR)
            end
          else
            vim.notify(".envrc already exists or no shell.nix found", vim.log.levels.WARN)
          end
        end
      '';
      options = {
        desc = "Create .envrc file";
        silent = true;
      };
    }
  ];

  # Add which-key group for direnv
  plugins.which-key.settings.spec = [
    {__raw = "{ '<leader>d', group = 'direnv' }";}
  ];
}
