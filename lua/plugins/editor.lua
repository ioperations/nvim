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
    -- text objects
    "wellle/targets.vim",
    -- multi cursor
    "mg979/vim-visual-multi",
    -- easy align
    "junegunn/vim-easy-align",
    -- surround
    "tpope/vim-surround",
    -- emacs keybinding
    "tpope/vim-rsi",
    -- undotree
    {
        "petertriho/nvim-scrollbar",
        enabled = false,
        config = function()
            require("scrollbar").setup()
        end,
    },
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
        "smoka7/hop.nvim",
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
        "shellRaining/hlchunk.nvim",
        enabled = false, -- comsume much too cpu when open large file
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("hlchunk").setup({
                chunk = {
                    enable = true,
                },
                indent = {
                    enable = true,
                    -- chars = {
                    --     "····",
                    -- },
                    style = {
                        -- "#aFa000",
                        -- "#aF7F00",
                        -- "#aFaa00",
                        -- "#a0aF00",
                        -- "#a0FFFF",
                        -- "#a0a0FF",
                        -- "#aBa0FF",
                        "#262928",
                        "#262a28",
                        "#262728",
                        "#262628",
                        "#262528",
                        "#262428",
                    },
                },
                line_num = {
                    enable = true,
                },
                blank = {
                    enable = false,
                },
            })
        end,
    },

    {
        "RRethy/vim-illuminate",
        enabled = false,
    },
    -- cursorline
    {
        "yamatsum/nvim-cursorline",
        enabled = false,
        config = function()
            require("nvim-cursorline").setup({
                cursorline = {
                    enable = true,
                    timeout = 1000,
                    number = false,
                },
                cursorword = {
                    enable = false,
                    min_length = 3,
                    hl = { underline = false },
                },
            })
        end,
    },

    {
        "andymass/vim-matchup",
        enabled = false,
    },

    -- todo fix etc
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup({
                keywords = {
                    FIX = {
                        icon = " ", -- icon used for the sign, and in search results
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
                -- build = function()
                --     vim.api.nvim_exec2([[call fzf#install()]], {})
                -- end,
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
    -- persistent
    -- Lua
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            -- add any custom options here
        },
    },
}
