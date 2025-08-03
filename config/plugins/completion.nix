{pkgs, ...}: {
  plugins = {
    # Main completion plugin
    cmp = {
      enable = true;
      
      settings = {
        # Completion sources
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "luasnip"; }
        ];
        
        # Key mappings
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif require("luasnip").jumpable(-1) then
                require("luasnip").jump(-1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
        };
        
        # Appearance
        formatting = {
          format = ''
            function(entry, vim_item)
              -- Icons for different types
              local kind_icons = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "",
              }
              
              vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
              })[entry.source.name]
              
              return vim_item
            end
          '';
        };
        
        # Window appearance
        window = {
          completion = {
            border = "rounded";
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
          };
          documentation = {
            border = "rounded";
          };
        };
        
        # Experimental features
        experimental = {
          ghost_text = true;
        };
      };
    };
    
    # Snippet engine (required for many completions)
    luasnip = {
      enable = true;
      fromVscode = [
        {
          # Load friendly-snippets (community snippet collection)
          paths = "${pkgs.vimPlugins.friendly-snippets}";
        }
      ];
    };
    
    # Additional completion sources
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;
    cmp-cmdline.enable = true;
    
    # For better Python completions
    cmp-nvim-lsp-signature-help.enable = true;
  };
  
  # Extra configuration for cmdline completion
  extraConfigLua = ''
    local cmp = require('cmp')
    
    -- `/` cmdline setup
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })
    
    -- `:` cmdline setup
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })
    
    -- Load custom snippets
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local fmt = require("luasnip.extras.fmt").fmt
    
    -- Python snippets
    ls.add_snippets("python", {
      -- Main function
      s("main", fmt([[
def main():
    {}

if __name__ == "__main__":
    main()
      ]], { i(1) })),
      
      -- Class with init
      s("class", fmt([[
class {}:
    def __init__(self{}):
        {}
      ]], { i(1, "ClassName"), i(2), i(3) })),
      
      -- Function with docstring
      s("def", fmt([[
def {}({}):
    """{}"""
    {}
      ]], { i(1, "function_name"), i(2), i(3, "Brief description"), i(4, "pass") })),
      
      -- Try/except block
      s("try", fmt([[
try:
    {}
except {} as e:
    {}
      ]], { i(1), i(2, "Exception"), i(3, "pass") })),
      
      -- Context manager
      s("with", fmt([[
with {} as {}:
    {}
      ]], { i(1), i(2, "f"), i(3) })),
      
      -- List comprehension
      s("lc", fmt("[ {} for {} in {} ]", { i(1, "x"), i(2, "x"), i(3, "iterable") })),
      
      -- Dict comprehension
      s("dc", fmt("{{ {}: {} for {} in {} }}", { i(1, "k"), i(2, "v"), i(3, "item"), i(4, "iterable") })),
      
      -- Pytest test
      s("test", fmt([[
def test_{}():
    {}
      ]], { i(1, "name"), i(2, "assert True") })),
      
      -- Dataclass
      s("dataclass", fmt([[
from dataclasses import dataclass

@dataclass
class {}:
    {}: {}
      ]], { i(1, "ClassName"), i(2, "field"), i(3, "type") })),
    })
    
    -- Go snippets
    ls.add_snippets("go", {
      -- Main function
      s("main", fmt([[
package main

import "fmt"

func main() {{
	{}
}}
      ]], { i(1) })),
      
      -- Function
      s("func", fmt([[
func {}({}) {} {{
	{}
}}
      ]], { i(1, "name"), i(2), i(3), i(4) })),
      
      -- Method
      s("meth", fmt([[
func ({} {}) {}({}) {} {{
	{}
}}
      ]], { i(1, "r"), i(2, "Receiver"), i(3, "method"), i(4), i(5), i(6) })),
      
      -- If error
      s("iferr", fmt([[
if err != nil {{
	{}
}}
      ]], { i(1, "return err") })),
      
      -- For loop
      s("for", fmt([[
for {} {{
	{}
}}
      ]], { i(1), i(2) })),
      
      -- For range
      s("forr", fmt([[
for {}, {} := range {} {{
	{}
}}
      ]], { i(1, "i"), i(2, "v"), i(3, "slice"), i(4) })),
      
      -- Struct
      s("struct", fmt([[
type {} struct {{
	{}
}}
      ]], { i(1, "Name"), i(2) })),
      
      -- Interface
      s("interface", fmt([[
type {} interface {{
	{}
}}
      ]], { i(1, "Name"), i(2) })),
      
      -- Test function
      s("test", fmt([[
func Test{}(t *testing.T) {{
	{}
}}
      ]], { i(1, "Name"), i(2) })),
      
      -- Benchmark function
      s("bench", fmt([[
func Benchmark{}(b *testing.B) {{
	for i := 0; i < b.N; i++ {{
		{}
	}}
}}
      ]], { i(1, "Name"), i(2) })),
      
      -- HTTP handler
      s("handler", fmt([[
func {}(w http.ResponseWriter, r *http.Request) {{
	{}
}}
      ]], { i(1, "handler"), i(2) })),
      
      -- Defer
      s("defer", fmt("defer {}", { i(1, "func()") })),
      
      -- Context TODO
      s("todo", fmt("// TODO: {}", { i(1) })),
    })
  '';
}
