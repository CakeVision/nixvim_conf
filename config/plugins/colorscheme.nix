{
  # Base16 allows us to create custom themes easily
  colorschemes.base16 = {
    enable = true;
    
    # Custom colorscheme with dark green bg and orange accents
    colorscheme = {
      # Special
      base00 = "#0a1612";  # Dark green (almost black) - Default Background
      base01 = "#0d1f1a";  # Lighter Background (Used for status bars, line highlighting)
      base02 = "#122620";  # Selection Background
      base03 = "#7a8a80";  # Comments, Invisibles, Line Highlighting
      base04 = "#8a9a90";  # Dark Foreground (Used for status bars)
      base05 = "#d4e5d0";  # Default Foreground, Caret, Delimiters, Operators
      base06 = "#e8f4e4";  # Light Foreground (Not often used)
      base07 = "#f5fdf3";  # Light Background (Not often used)
      
      # Colors
      base08 = "#d4572a";  # Muted Orange - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base09 = "#cc6633";  # Burnt Orange - Integers, Boolean, Constants, XML Attributes
      base0A = "#b8860b";  # Dark Goldenrod - Classes, Markup Bold, Search Text Background
      base0B = "#2d5016";  # Forest Green - Strings, Inherited Class, Markup Code, Diff Inserted
      base0C = "#458b74";  # Sea Green - Support, Regular Expressions, Escape Characters
      base0D = "#4682b4";  # Steel Blue - Functions, Methods, Attribute IDs, Headings
      base0E = "#a0522d";  # Sienna Brown - Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0F = "#8b4726";  # Saddle Brown - Deprecated, Opening/Closing Embedded Language Tags
    };
  };
  
  # Additional highlight overrides for better todo-comments visibility
  highlight = {
    # Todo comment highlights with custom backgrounds
    TodoBgTODO = {
      bg = "#4682b4";  # Steel blue
      fg = "#0a1612";
      bold = true;
    };
    TodoBgFIX = {
      bg = "#d4572a";  # Muted orange
      fg = "#0a1612";
      bold = true;
    };
    TodoBgHACK = {
      bg = "#b8860b";  # Dark goldenrod
      fg = "#0a1612";
      bold = true;
    };
    TodoBgWARN = {
      bg = "#a0522d";  # Sienna
      fg = "#f5fdf3";
      bold = true;
    };
    TodoBgPERF = {
      bg = "#458b74";  # Sea green
      fg = "#0a1612";
      bold = true;
    };
    TodoBgNOTE = {
      bg = "#2d5016";  # Forest green
      fg = "#f5fdf3";
      bold = true;
    };
    
    # Better diff colors
    DiffAdd = {
      bg = "#122620";
      fg = "#16c60c";
    };
    DiffDelete = {
      bg = "#2a1616";
      fg = "#ff6b35";
    };
    DiffChange = {
      bg = "#1f1a0f";
      fg = "#ffa62b";
    };
    
    # Cursor line (subtle green tint)
    CursorLine = {
      bg = "#0d1f1a";
    };
    
    # Visual selection (orange tint)
    Visual = {
      bg = "#3a2215";
    };
    
    # Search highlighting
    Search = {
      bg = "#cc6633";  # Burnt orange
      fg = "#0a1612";
      bold = true;
    };
    IncSearch = {
      bg = "#b8860b";  # Dark goldenrod
      fg = "#0a1612";
      bold = true;
    };
  };
}
