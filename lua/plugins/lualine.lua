local function project()
    return "λ >> " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " << λ"
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
                },
                lualine_c = {

                    {
                        "filename",
                        file_status = true,
                        path = 1,
                        color = { fg = "#0feaaf", bg = nil, gui = "" },
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
                        "g:coc_status",
                    },
                },
                lualine_x = {
                    "encoding",
                    "fileformat",
                    {
                        color = { fg = "#ffaa88", bg = nil, gui = "bold" },
                        project,
                    },
                },
                lualine_y = {
                    "filetype",
                    "progress",
                },
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
