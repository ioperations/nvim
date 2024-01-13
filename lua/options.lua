vim.opt.relativenumber = true
-- vim.opt.cursorline = true -- show the cursor line
-- vim.opt.cursorcolumn = true -- show the cursor column
vim.opt.mouse = "a" -- enable mouse
vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.smartcase = true -- ignores case for search unless a capital is used in search
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- spaces instead of tabs
vim.opt.number = true
vim.opt.textwidth = 80
vim.opt.linebreak = true
vim.opt.scrolloff = 10
vim.opt.wrap = true

-- coc.nvim need this
vim.opt.backup = false
vim.opt.writebackup = false
--
-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- vim.opt.cmdheight = 2
vim.opt.showmode = true
vim.opt.numberwidth = 5 -- wider gutter
vim.opt.linebreak = true -- don't break words on wrap
vim.opt.smartindent = true
vim.opt.completeopt = "menuone,noselect" -- nvim-cmp
-- vim.opt.completeopt = {"menuone", "longest", "preview"}
vim.opt.signcolumn = "yes" -- always show the signcolumn
vim.opt.termguicolors = true

-- spelling
vim.opt.spelllang = "en_gb,en_us"
vim.opt.mousemodel = "popup"
-- timeout for whichkey
vim.opt.timeoutlen = 500
vim.opt.pumheight = 17
vim.g.coc_current_word_highlight_delay = 2000

-- Neovide settings

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.colorschema = "lunar"
-- highlight on yank
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])

-- fileencoding
vim.cmd([[set fileencodings=utf-8,gb2312,gbk,gb18030]])

-- Vertically center document when entering insert mode
-- vim.cmd([[autocmd InsertEnter * norm zz]])

-- detect mdx file and set file type to markdown
vim.cmd([[autocmd BufNewFile,BufRead *.mdx set filetype=markdown.mdx]])

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})

-- Give me some fenced codeblock goodness
vim.g.markdown_fenced_languages = {
    "html",
    "javascript",
    "javascriptreact",
    "typescript",
    "json",
    "css",
    "scss",
    "lua",
    "vim",
    "bash",
    "ts=typescript",
    "js=javascript",
}

if vim.loop.os_uname().sysname ~= "Windows_NT" then
    vim.cmd("source " .. vim.fn.stdpath("config") .. "/vim/langtemplate.vim")
else
    vim.cmd("source " .. vim.fn.stdpath("config") .. "\\vim\\langtemplate.vim")
end
-- ~/.locals/share/nvim/lsp.log
-- vim.lsp.set_log_level(vim.log.levels.TRACE)
