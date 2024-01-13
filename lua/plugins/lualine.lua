--
local function filepath()
    return vim.fn.expand("%:.")
end

local function project()
    return "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = true,
                component_separators = { left = "●", right = "●" },
                section_separators = "",
                disabled_filetypes = {},
                theme = "tokyonight",
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },

                lualine_b = {
                    -- color = { fg = "#ffaa88", bg = nil, gui = "bold" },
                    project,
                },
                lualine_c = {

                    {
                        filepath,
                        file_status = true,
                        path = 1,
                        color = { fg = "#ffaa88", bg = nil, gui = "" },
                    },
                    "diff",
                    {
                        "diagnostics",
                        sources = { "coc" },
                        sections = { "error", "warn", "info", "hint" },
                        symbols = { error = " ", warn = " ", info = " ", hint = "💡" },
                        diagnostics_color = {
                            -- Same values as the general color option can be used here.
                            error = "DiagnosticError", -- Changes diagnostics' error color.
                            warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
                            info = "DiagnosticInfo", -- Changes diagnostics' info color.
                            hint = "DiagnosticHint", -- Changes diagnostics' hint color.
                        },
                        colored = true, -- Displays diagnostics status in color if set to true.
                        update_in_insert = false, -- Update diagnostics in insert mode.
                        always_visible = false, -- Show diagnostics even if there are none.
                    },
                    {
                        "b:coc_lightbulb_status",
                        "g:coc_status",
                        color = { fg = nil, bg = "#17161e", gui = "" },
                    },
                },
                lualine_x = {
                    "encoding",
                    "fileformat",
                    "filetype",
                },
                lualine_y = {
                    "branch",
                },
                lualine_z = { "progress", "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = { "fugitive" },
        },
    },
    -- bufline
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            local bufferline = require("bufferline")
            bufferline.setup({
                options = {
                    style = bufferline.style_preset.slant,
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = { "close" },
                    },
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
                    diagnostics = "coc",
                    max_name_length = 22,
                    tab_size = 22,
                },
            })
        end,
    },
}
