local function relativepath()
    return vim.fn.expand("%:.")
end

local function project()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end
return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = true,
                component_separators = { left = "", right = "" },
                section_separators = "",
                disabled_filetypes = {},
                theme = "lunar",
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    "branch",
                    {
                        color = { fg = "#ffaa88", bg = nil, gui = "underline,bold" },
                        project,
                    },
                    {
                        color = { fg = "#8faa88", bg = nil, gui = "italic,bold" },
                        relativepath,
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
                },
                lualine_c = {
                    {
                        "g:coc_status",
                    },
                },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
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
}
