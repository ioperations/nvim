return {
    -- welcome
    "dstein64/vim-startuptime",
    {
        "goolord/alpha-nvim",
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.startify")

            -- -- Set header
            dashboard.section.header.val = {
                "                                                     ",
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                "                                                     ",
            }

            -- Send config to alpha
            alpha.setup(dashboard.opts)

            -- Disable folding on alpha buffer
            vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
        end,
    },

    -- scrollbar
    --    {
    --        "petertriho/nvim-scrollbar",
    --        config = function()
    --            require("scrollbar").setup({
    --                show = true,
    --                show_in_active_only = true,
    --                set_highlights = true,
    --                folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
    --                max_lines = false, -- disables if no. of lines in buffer exceeds this
    --                handle = {
    --                    text = " ",
    --                    color = "#5f6f9f",
    --                    cterm = nil,
    --                    -- highlight = "CursorColumn",
    --                    hide_if_all_visible = false, -- Hides handle if all lines are visible
    --                },
    --                marks = {
    --                    Cursor = {
    --                        -- text = "•",
    --                        text = "─",
    --                        priority = 0,
    --                        color = "#7f7f7f",
    --                        cterm = nil,
    --                        -- highlight = "Normal",
    --                    },
    --                },
    --                excluded_buftypes = {
    --                    "terminal",
    --                },
    --                excluded_filetypes = {
    --                    "prompt",
    --                    "TelescopePrompt",
    --                    "noice",
    --                    "alpha",
    --                    "NvimTree",
    --                    "",
    --                },
    --                autocmd = {
    --                    render = {
    --                        "BufWinEnter",
    --                        "TabEnter",
    --                        "TermEnter",
    --                        "WinEnter",
    --                        "CmdwinLeave",
    --                        "TextChanged",
    --                        "VimResized",
    --                        "WinScrolled",
    --                    },
    --                    clear = {
    --                        "BufWinLeave",
    --                        "TabLeave",
    --                        "TermLeave",
    --                        "WinLeave",
    --                    },
    --                },
    --                handlers = {
    --                    cursor = true,
    --                    diagnostic = false,
    --                    gitsigns = false, -- Requires gitsigns
    --                    handle = true,
    --                    search = false, -- Requires hlslens
    --                },
    --            })
    --        end,
    --    },

    "ioperations/vim-cppman",
    -- edit enhancement
    "gcmt/wildfire.vim",
    -- multi cursor
    "mg979/vim-visual-multi",
    -- easy align
    "junegunn/vim-easy-align",
    -- surround
    "tpope/vim-surround",
    -- undotree
    {
        "mbbill/undotree",
        config = function()
            vim.cmd([[
        if has("persistent_undo")
           let target_path = expand('~/.undodir')
            " create the directory and any parent directories
            " if the location does not exist.
            if !isdirectory(target_path)
                call mkdir(target_path, "p", 0700)
            endif
            let &undodir=target_path
            set undofile
        endif
        ]])
        end,
    },

    -- easy motion
    {
        "phaazon/hop.nvim",
        opts = {
            as = "hop",
            keys = "etovxqpdygfblzhckisuran",
        },
        config = function(_, opts)
            require("hop").setup(opts)
        end,
    },

    -- indent
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup()
        end,
    },

    -- cursorline
    {
        "yamatsum/nvim-cursorline",
        config = function()
            require("nvim-cursorline").setup({
                cursorline = {
                    enable = true,
                    timeout = 1000,
                    number = false,
                },
                cursorword = {
                    enable = true,
                    min_length = 3,
                    hl = { underline = true },
                },
            })
        end,
    },

    -- colorschema
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
        config = function(_, opts)
            -- require("tokyonight").setup(opts) -- opts here are passed from above
            -- vim.cmd("highlight WinSeparator guifg=" .. colors.bg_highlight)
            vim.cmd([[colorscheme lunar]])
        end,
    },

    -- bufline
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        opts = {
            options = {
                offsets = {
                    {
                        filetype = "NvimTree",
                        -- text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
                diagnostics = "nvim_lsp",
                max_name_length = 22,
                tab_size = 22,
            },
        },
    },

    -- todo fix etc
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup({
                keywords = {
                    FIX = {
                        icon = "", -- icon used for the sign, and in search results
                        color = "error", -- can be a hex color, or a named color (see below)
                        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                        -- signs = false, -- configure signs for some keywords individually
                    },
                    TODO = { icon = " ", color = "info" },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
                },
            })
        end,
        dependencies = { -- looking
            { "numToStr/Comment.nvim" },
            {
                "christianchiarulli/nvim-ts-rainbow",
                lazy = true,
                config = function()
                    require("nvim-treesitter.configs").setup({
                        highlight = {
                            -- ...
                        },
                        -- ...
                        rainbow = {
                            enable = true,
                            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                            max_file_lines = nil, -- Do not enable for files with more than n lines, int
                            -- colors = {}, -- table of hex strings
                            -- termcolors = {} -- table of colour name strings
                        },
                    })
                end,
            },
        },
    },
    -- smater cd
    {
        "nanotee/zoxide.vim",
        dependencies = {
            {
                "junegunn/fzf",
                build = function()
                    vim.api.nvim_exec([[call fzf#install()]], false)
                end,
            },
            "junegunn/fzf.vim",
        },
    },
    -- markdown preview
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }

            if vim.fn.has("mac") == 1 then
                vim.g.mkdp_browser = "/Applications/Firefox.app/Contents/MacOS/firefox"
            else
                vim.g.mkdp_browser = "firefox"
            end
        end,
    },

    -- task
    {
        "tpope/vim-dotenv",
        "skywind3000/asyncrun.extra",
        "voldikss/vim-floaterm",
        "skywind3000/asynctasks.vim",
        {
            "skywind3000/asyncrun.vim",
            config = function()
                require("scripts")
            end,
        },
    },
}
