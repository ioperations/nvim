return {
    { "rickhowe/diffchar.vim" },
    {
        "sindrets/diffview.nvim",
        config = function()
            require("diffview").setup({
                enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
                use_icons = true, -- Requires nvim-web-devicons
                show_help_hints = false, -- Show hints for how to open the help panel

                keymaps = {
                    disable_defaults = false, -- Disable the default keymaps
                    view = {
                        { "n", "q", "<Cmd>q!<CR>", { desc = "close" } },
                    },
                },
            })
        end,
    },
    {
        "f-person/git-blame.nvim",
        -- load the plugin at startup
        event = "VeryLazy",
        -- Because of the keys part, you will be lazy loading this plugin.
        -- The plugin will only load once one of the keys is used.
        -- If you want to load the plugin at startup, add something like event = "VeryLazy",
        -- or lazy = false. One of both options will work.
        opts = {
            -- your configuration comes here
            -- for example
            enabled = true, -- if you want to enable the plugin
            message_template = "        <author> • <date> • <summary>", -- template for the blame message, check the Message template section for more options
            date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
            virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
        },
        config = function(_, opts)
            vim.g.gitblame_schedule_event = "CursorHold"
            vim.g.gitblame_clear_event = "CursorHoldI"
            vim.g.gitblame_delay = 1000
            require("gitblame").setup(opts)
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        enabled = false,
        lazy = true,
        config = function()
            require("gitsigns").setup({
                -- signs = {
                --     add = { text = "+" },
                --     change = { text = "~" },
                --     delete = { text = "_" },
                --     topdelete = { text = "‾" },
                --     changedelete = { text = "-" },
                --     untracked = { text = "┆" },
                -- },
                signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true,
                },
                attach_to_untracked = true,
                current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 10,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = "            <author_mail>, <author_time:%Y-%m-%d> - <summary>",
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = "single",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
            })
        end,
        event = "User FileOpened",
        cmd = "Gitsigns",
    },
    {
        "akinsho/git-conflict.nvim",
        config = function()
            vim.api.nvim_exec2([[ hi my_gitdiffadd guibg=#333c3e ]], {})
            require("git-conflict").setup({
                highlights = { -- They must have background color, otherwise the default color will be used
                    incoming = "DiffText",
                    current = "my_gitdiffadd",
                },
            })
        end,
    },
    { "tpope/vim-fugitive" },
}
