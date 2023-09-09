return {

    -- git
    -- "f-person/git-blame.nvim",
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "-" },
                    untracked = { text = "┆" },
                },
                signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true,
                },
                attach_to_untracked = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 10,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
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
                yadm = {
                    enable = false,
                },
            })
        end,
        event = "User FileOpened",
        cmd = "Gitsigns",
    },
    {
        "akinsho/git-conflict.nvim",
        lazy = true,
        config = function()
            vim.api.nvim_exec([[ hi my_gitdiffadd guibg=#333c3e ]], false)
            require("git-conflict").setup({
                highlights = { -- They must have background color, otherwise the default color will be used
                    incoming = "DiffText",
                    current = "my_gitdiffadd",
                },
            })
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        config = function()
            require("telescope").load_extension("lazygit")
            vim.api.nvim_exec([[autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()]], false)
        end,
    },

    -- {
    --     "airblade/vim-gitgutter",
    --     config = function()
    --         vim.opt.updatetime = 400
    --     end,
    -- },
    { "tpope/vim-fugitive", lazy = true },
}
