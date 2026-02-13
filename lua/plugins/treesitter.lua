return {
    { "nickhutchinson/vim-systemtap" },
    { "mmarchini/bpftrace.vim" },
    { "whatyouhide/vim-tmux-syntax" },
    {
        "HiPhish/rainbow-delimiters.nvim",
        enabled = false,
        config = function()
            -- This module contains a number of default definitions
            local rainbow_delimiters = require("rainbow-delimiters")
            require("rainbow-delimiters.setup").setup({
                strategy = {
                    -- ...
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            })
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }
            local hooks = require("ibl.hooks")
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup({ scope = { highlight = highlight } })

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = false,
        config = function()
            require("treesitter-context").setup({
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            })
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "windwp/nvim-ts-autotag",
            --"christianchiarulli/nvim-ts-rainbow",
        },

        opts = {
            context_commentstring = {
                enable = true,
            },
            ensure_installed = {
                "bash",
                "vimdoc",
                "html",
                "javascript",
                "typescript",
                "tsx",
                "json",
                "lua",
                "astro",
                "vue",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "vim",
                "yaml",
                "go",
                "python",
                "rust",
                "vim",
                "css",
                "cpp",
                "c",
            }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
            -- ignore_install = {}, -- List of parsers to ignore installing

            rainbow = {
                enable = true,
                -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil, -- Do not enable for files with more than n lines, int
            },
            highlight = {
                enable = true, -- false will disable the whole extension
                disable = function(lang, bufnr) -- Disable in large typescript buffers i.e. type definitions
                    return lang == "typescript" and vim.api.nvim_buf_line_count(bufnr) > 5000
                end,
            },

            auto_install = true,
            autotag = {
                enable = true,
                filetypes = {
                    "html",
                    "javascript",
                    "typescript",
                    "javascriptreact",
                    "typescriptreact",
                    "svelte",
                    "vue",
                    "tsx",
                    "jsx",
                    "markdown",
                    -- NOTE: not working in astro
                    -- https://github.com/windwp/nvim-ts-autotag/pull/89
                    "astro",
                },
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = "<c-s>",
                    node_decremental = "<c-backspace>",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]]"] = "@function.outer",
                        ["]m"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[["] = "@function.outer",
                        ["[m"] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.config").setup(opts)
            -- FIX: for nvim-autotag - not actually working
            -- local ts_utils = require("nvim-treesitter.ts_utils")
            -- ts_utils.get_node_text = vim.treesitter.query.get_node_text

            -- Detect astro files and set filetype
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = { "*.astro" },
                callback = function()
                    vim.cmd([[ set filetype=astro ]])
                end,
            })
        end,
    },
}
