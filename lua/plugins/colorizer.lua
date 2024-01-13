return {
    -- colorschema
    {
        "morhetz/gruvbox",
    },
    {
        "lunarvim/lunar.nvim",
        -- lazy = true,
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
        config = function()
            -- require("tokyonight").setup(opts) -- opts here are passed from above
            -- vim.cmd("highlight WinSeparator guifg=" .. colors.bg_highlight)
            -- vim.cmd([[colorscheme lunar]])
        end,
    },

    {
        "folke/tokyonight.nvim",
        config = function()
            -- require("tokyonight").setup({
            --     on_highlights = function(hl, c)
            --         local prompt = "#2d3149"
            --         hl.TelescopeNormal = {
            --             bg = c.bg_dark,
            --             fg = c.fg_dark,
            --         }
            --         hl.TelescopeBorder = {
            --             bg = c.bg_dark,
            --             fg = c.bg_dark,
            --         }
            --         hl.TelescopePromptNormal = {
            --             bg = prompt,
            --         }
            --         hl.TelescopePromptBorder = {
            --             bg = prompt,
            --             fg = prompt,
            --         }
            --         hl.TelescopePromptTitle = {
            --             bg = prompt,
            --             fg = prompt,
            --         }
            --         hl.TelescopePreviewTitle = {
            --             bg = c.bg_dark,
            --             fg = c.bg_dark,
            --         }
            --         hl.TelescopeResultsTitle = {
            --             bg = c.bg_dark,
            --             fg = c.bg_dark,
            --         }
            --     end,
            -- })
            vim.cmd([[colorscheme tokyonight]])
            vim.api.nvim_exec2([[hi CocInlayHint guibg=None guifg='#5f6f9f' ctermbg=Red ctermfg=Blue]], {})
            vim.api.nvim_exec2([[hi CocInlayHintParameter guibg=None guifg=#565f89 ctermbg=Red ctermfg=Blue]], {})
            vim.api.nvim_exec2([[hi CocInlayHintType guibg=None guifg='#5f6f9f' ctermbg=Red ctermfg=Blue]], {})
            vim.api.nvim_exec2([[hi CocCodeLens guibg=None guifg='#5f6f9f' ctermbg=Red ctermfg=Blue]], {})
        end,
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
