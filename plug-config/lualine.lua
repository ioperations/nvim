require'lualine'.setup{
    options = {
        icons_enabled = true,
        theme  = 'gruvbox'
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'g:coc_status','bo:filetype'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {},
    tabline = {},
    extensions = {'quickfix'}
}
