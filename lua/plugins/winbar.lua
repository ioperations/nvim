return {
    -- winbar
    "SmiteshP/nvim-navic",
    dependencies = {
        "nvim-web-devicons",
    },
    config = function()
        vim.api.nvim_create_augroup("_winbar", {})

        vim.api.nvim_create_autocmd({
            "BufEnter",
        }, {
            group = "_winbar",
            pattern = "*",
            callback = function()
                if vim.bo.filetype == "fugitiveblame" then
                    local value = "A Git wrapper so awesome, it should be illegal"
                    vim.api.nvim_set_option_value("winbar", value, { scope = "local" })
                end
            end,
        })

        -- create_winbar()
        local navic = require("nvim-navic")
        navic.setup({
            depth_limit = 0,
            depth_limit_indicator = "..",
            highlight = true,
            lsp = {
                auto_attach = true,
            },
            icons = {
                Array = " ",
                Boolean = " ",
                Class = " ",
                Color = " ",
                Constant = " ",
                Constructor = " ",
                Enum = " ",
                EnumMember = " ",
                Event = " ",
                Field = " ",
                File = " ",
                Folder = "󰉋 ",
                Function = " ",
                Interface = " ",
                Key = " ",
                Keyword = " ",
                Method = " ",
                Module = " ",
                Namespace = " ",
                Null = "󰟢 ",
                Number = " ",
                Object = " ",
                Operator = " ",
                Package = " ",
                Property = " ",
                Reference = " ",
                Snippet = " ",
                String = " ",
                Struct = " ",
                Text = " ",
                TypeParameter = " ",
                Unit = " ",
                Value = " ",
                Variable = " ",
            },
            separator = "  ",
        })
    end,
}
