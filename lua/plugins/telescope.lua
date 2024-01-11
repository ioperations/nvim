return {
    -- project
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = true,
                },

                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", ".cache", "stack.yaml", "hs.cabal" },
            })
        end,
        lazy = false,
    },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    { "nvim-telescope/telescope-dap.nvim", lazy = true },
    { "nvim-telescope/telescope-live-grep-args.nvim", lazy = true },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "rmagatti/session-lens",
            "nvim-telescope/telescope-file-browser.nvim",
            "fannheyward/telescope-coc.nvim",
            "BurntSushi/ripgrep",
        },
        lazy = false,
        cmd = "Telescope",
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },
            coc = {
                prefer_locations = false, -- always use Telescope locations to preview definitions/declarations/implementations etc
            },
        },
        config = function()
            local telescope = require("telescope")
            local opts = {
                defaults = {
                    theme = "dropdown", --- @type telescope_themes
                    file_ignore_patterns = { ".git/", "node_modules/", "env/", "target/", "build", "cmake-build*/" }, -- ignore git
                    winblend = 0,
                    prompt_prefix = " ",
                    selection_caret = " ",
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--glob=!.git/",
                    },
                    path_display = { "smart" },
                    color_devicons = true,
                    layout_config = {
                        horizontal = {
                            height = 0.95,
                            preview_cutoff = 120,
                            prompt_position = "bottom",
                            width = 0.9,
                            preview_width = 0.65,
                        },
                    },

                    mappings = {
                        i = {
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                            ["<C-f>"] = function(...)
                                return require("telescope.actions").preview_scrolling_down(...)
                            end,
                            ["<C-b>"] = function(...)
                                return require("telescope.actions").preview_scrolling_up(...)
                            end,
                            ["<C-d>"] = function(...)
                                return require("telescope.actions").preview_scrolling_down(...)
                            end,
                            ["<C-u>"] = function(...)
                                return require("telescope.actions").preview_scrolling_up(...)
                            end,
                        },
                        n = {
                            ["q"] = function(...)
                                return require("telescope.actions").close(...)
                            end,
                            ["<C-n>"] = require("telescope.actions").move_selection_next,
                            ["<C-p>"] = require("telescope.actions").move_selection_previous,
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                            ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
                            ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
                            ["<C-f>"] = require("telescope.actions").preview_scrolling_down,
                            ["<C-b>"] = require("telescope.actions").preview_scrolling_up,
                        },
                    },
                },
            }
            telescope.setup(opts)

            -- telescope.load_extension("session-lens")
            telescope.load_extension("file_browser")
            telescope.load_extension("projects")
            telescope.load_extension("fzf")
            telescope.load_extension("dap")
            telescope.load_extension("live_grep_args")
            telescope.load_extension("coc")
        end,
    },
}
