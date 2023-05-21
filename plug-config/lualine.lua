local opts = {
    options = {
        icons_enabled = true,
        component_separators = { left = "●", right = "●" },
        section_separators = "",
        disabled_filetypes = {},
        theme = "gruvbox",
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "g:coc_status" },
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
    extensions = { "fugitive", "nvim-tree" },
}
require('lualine').setup(opts)
