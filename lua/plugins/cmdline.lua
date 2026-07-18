return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        {
            "rcarriga/nvim-notify",
            config = {
                top_down = false,
                max_width = function()
                    return 8 * vim.api.nvim_win_get_width(0) / 10
                end,
            },
        },
    },
    config = function()
        require("noice").setup({
            -- THE FIX: Instead of disabling it (which breaks input),
            -- force it to render layout inside the native bottom row.
            cmdline = {
                view = "cmdline", -- Moves the text prompt directly to the absolute bottom left
            },
            popupmenu = {
                enabled = false, -- Disables the pop-up autocompletion dropdown for commands
            },
            messages = {
                enabled = true, -- Leaves the backend on so Noice catches notifications
            },
            lsp = {
                progress = {
                    enabled = true, -- Keeps your LSP loading spinners/popups active
                },
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            presets = {
                bottom_search = true, -- Forces / and ? search inputs to stay at the bottom too
                command_palette = false, -- Stops inputs from ever shifting to the upper center screen
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
        })
    end,
}
