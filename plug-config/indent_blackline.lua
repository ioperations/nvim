vim.opt.list = true

local set = vim.opt -- set options
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_end_of_line = true,
    show_current_context = true,
    show_current_context_start = true,
}
