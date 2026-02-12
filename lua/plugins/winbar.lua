return {
    -- winbar
    "utilyre/barbecue.nvim",
    dependencies = {
        "SmiteshP/nvim-navic",
        dependencies = {
            "nvim-web-devicons",
            "neovim/nvim-lspconfig",
        },
        config = function()
            --
            -- create_winbar()
            vim.g.navic_silence = false
            vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
            local navic = require("nvim-navic")
            navic.setup({
                depth_limit = 0,
                lazy_update_context = true,
                depth_limit_indicator = "..",
                highlight = true,
                lsp = {
                    auto_attach = true,
                    preference = { "ccls" },
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
                    Function = "󰡱 ",
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

            vim.api.nvim_create_augroup("_winbar", {})

            vim.api.nvim_create_autocmd({
                "BufEnter",
            }, {
                group = "_winbar",
                pattern = "*",
                callback = function()
                    local filetypes =
                        { "c", "cpp", "inc", "lua", "sh", "javascript", "typescript", "rust", "go", "python", "vim" }
                    if vim.bo.filetype == "fugitiveblame" then
                        local value = "A Git wrapper so awesome, it should be illegal"
                        vim.api.nvim_set_option_value("winbar", value, { scope = "local" })
                    elseif vim.tbl_contains(filetypes, vim.bo.filetype, {}) then
                        vim.api.nvim_set_option_value("winbar", " ", { scope = "local" })
                    end
                end,
            })
        end,
    },
    config = function()
        -- triggers CursorHold event faster

        -- vim.opt.updatetime = 200

        require("barbecue").setup({
            create_autocmd = false, -- prevent barbecue from updating itself automatically
        })

        vim.api.nvim_create_autocmd({
            "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
            "BufWinEnter",
            "CursorHold",
            "InsertLeave",

            -- include this if you have set `show_modified` to `true`
            "BufModifiedSet",
        }, {
            group = vim.api.nvim_create_augroup("barbecue.updater", {}),
            callback = function()
                require("barbecue.ui").update()
            end,
        })

        -- require("barbecue").setup()
    end,
}
