return {
    -- colorschema
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            -- lunar specific
            vim.cmd("colorscheme " .. vim.g.colorschema)
            vim.cmd([[hi CocInlayHint guibg=None guifg='#5f6f9f' ctermbg=Red ctermfg=Blue]])
            vim.cmd([[hi CocInlayHintParameter guibg=None guifg=#565f89 ctermbg=Red ctermfg=Blue]])
            vim.cmd([[ hi CocInlayHintType guibg=None guifg='#5f6f9f' ctermbg=Red ctermfg=Blue]])
            vim.cmd([[ hi CocCodeLens guibg=None guifg='#5f6f9f' ctermbg=Red ctermfg=Blue]])

            vim.cmd([[ hi diffRemoved guifg=#f43753 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE ]])
            vim.cmd([[ hi diffChanged guifg=#b3deef ctermfg=153 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE]])
            vim.cmd([[ hi diffAdded guifg=#c9d05c ctermfg=185 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE]])
            vim.cmd([[ hi diffSubname guifg=#9faa00 ctermfg=142 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE]])

            vim.cmd([[ hi DiffAdd guifg=NONE ctermfg=NONE guibg=#465902 ctermbg=238 gui=NONE cterm=NONE]])
            vim.cmd([[ hi DiffChange guifg=NONE ctermfg=NONE guibg=#41414f ctermbg=239 gui=NONE cterm=NONE]])
            vim.cmd([[ hi DiffDelete guifg=#f43753 ctermfg=203 guibg=#79313c ctermbg=237 gui=NONE cterm=NONE]])
            vim.cmd([[ hi DiffText guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE gui=reverse cterm=reverse]])
        end,
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
