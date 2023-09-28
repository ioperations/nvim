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

    "ioperations/vim-cppman",
    -- edit enhancement
    "gcmt/wildfire.vim", -- smart selection
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
        config = function()
            -- require("tokyonight").setup(opts) -- opts here are passed from above
            -- vim.cmd("highlight WinSeparator guifg=" .. colors.bg_highlight)
            vim.cmd([[colorscheme lunar]])
            vim.api.nvim_exec2([[hi CocInlayHint guibg=None guifg='#5f6f9f' ctermbg=Red ctermfg=Blue]], {})
            vim.api.nvim_exec2([[hi CocInlayHintParameter guibg=None guifg=#565f89 ctermbg=Red ctermfg=Blue]], {})
            vim.api.nvim_exec2([[hi CocInlayHintType guibg=None guifg='#5f6f9f' ctermbg=Red ctermfg=Blue]], {})
            vim.api.nvim_exec2([[hi CocCodeLens guibg=None guifg='#5f6f9f' ctermbg=Red ctermfg=Blue]], {})
        end,
    },

    "andymass/vim-matchup",

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
                        filetype = "undotree",
                        text = "Undotree",
                        highlight = "PanelHeading",
                        padding = 1,
                    },
                    {
                        filetype = "NvimTree",
                        text = "Explorer",
                        highlight = "PanelHeading",
                        padding = 1,
                    },
                    {
                        filetype = "DiffviewFiles",
                        text = "Diff View",
                        highlight = "PanelHeading",
                        padding = 1,
                    },
                    {
                        filetype = "flutterToolsOutline",
                        text = "Flutter Outline",
                        highlight = "PanelHeading",
                    },
                    {
                        filetype = "lazy",
                        text = "Lazy",
                        highlight = "PanelHeading",
                        padding = 1,
                    },
                    {
                        filetype = "fugitiveblame",
                        text = "Fugitiveblame",
                        highlight = "PanelHeading",
                        padding = 1,
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
        lazy = true,
        cmd = "Zi",
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
        lazy = true,
        cmd = "MarkdownPreview",
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
        "honza/vim-snippets",
        { "tpope/vim-dotenv" },
        { "voldikss/vim-floaterm" },
        { "skywind3000/asynctasks.vim", lazy = true, cmd = "AsyncTask" },
        {
            "skywind3000/asyncrun.vim",
            lazy = true,
            dependencies = {
                { "skywind3000/asyncrun.extra" },
            },
            cmd = "AsyncRun",
        },
    },
}
