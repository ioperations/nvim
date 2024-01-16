return {
    -- colorschema
    {
        "morhetz/gruvbox",
        dependencies = {
            {
                "lunarvim/lunar.nvim",
                opts = {
                    style = "night",
                    transparent = true,
                    styles = {
                        sidebars = "transparent",
                        floats = "transparent",
                    },
                },
                config = function()
                    -- lunar specific
                    vim.cmd("colorscheme " .. vim.g.colorschema)
                    vim.api.nvim_exec2([[hi CocInlayHint guibg=None guifg='#5f6f9f' ctermbg=Red ctermfg=Blue]], {})
                    vim.api.nvim_exec2(
                        [[hi CocInlayHintParameter guibg=None guifg=#565f89 ctermbg=Red ctermfg=Blue]],
                        {}
                    )
                    vim.api.nvim_exec2([[hi CocInlayHintType guibg=None guifg='#5f6f9f' ctermbg=Red ctermfg=Blue]], {})
                    vim.api.nvim_exec2([[hi CocCodeLens guibg=None guifg='#5f6f9f' ctermbg=Red ctermfg=Blue]], {})
                end,
            },
            {
                "folke/tokyonight.nvim",
                enable = false,
            },
        },
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            filetypes = { "*", "!cpp", "!c", "!rust", "!go", "!java", "!sh" },
            user_default_options = {
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                -- Available modes for `mode`: foreground, background,  virtualtext
                mode = "background", -- Set the display mode.
                -- Available methods are false / true / "normal" / "lsp" / "both"
                -- True is same as normal
                tailwind = true, -- Enable tailwind colors
                -- parsers can contain values used in |user_default_options|
                sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
                virtualtext = "■",
            },
            -- all the sub-options of filetypes apply to buftypes
            buftypes = {},
        },
    },
}
