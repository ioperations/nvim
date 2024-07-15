local function register_mappings(mappings, default_options)
    for mode, mode_mappings in pairs(mappings) do
        for _, mapping in pairs(mode_mappings) do
            local options = #mapping == 3 and table.remove(mapping) or default_options
            local prefix, cmd = unpack(mapping)
            pcall(vim.keymap.set, mode, prefix, cmd, options)
        end
    end
end

local function telescope_find_files()
    require("telescope.builtin").find_files({ hidden = true })
end

-- NOTE<cmd> <leader> prefixed mappings are in whichkey-settings.lua

local mappings = {
    i = {
        -- Insert mode
        { "kk", "<ESC>" },
        { "jj", "<ESC>" },
        { "jk", "<ESC>" },
        -- Terminal window navigation
        -- Ctrl single quote for backtick
        { "<C-'>", "``<esc>i" },
        { "<C-p>", "<up>" },
        { "<C-n>", "<down>" },
        { "<C-a>", "<c-o>I" },
        { "<C-e>", "<c-o>A" },
        { "<C-s>", "<esc>:w<cr>" },

        { "<C-f>", "<Right>" },
        { "<C-b>", "<Left>" },
    },
    n = {
        -- Normal mode
        -- Better window movement
        -- NOTE: replaced with Navigator for Wezterm and Tmux
        -- { "<C-h>", "<C-w>h", { silent = true } },
        -- { "<C-j>", "<C-w>j", { silent = true } },
        -- { "<C-k>", "<C-w>k", { silent = true } },
        -- { "<C-l>", "<C-w>l", { silent = true } },
        -- Resize with arrows

        -- window management
        { "<up>", ":res +5<cr>" },
        { "<down>", ":res -5<cr>" },
        { "<left>", ":vertical resize -5<cr>" },
        { "<right>", ":vertical resize +5<cr>" },

        -- lsp
        { "gR", "<Plug>(coc-rename)" },
        { "gD", "<cmd>Telescope coc declarations<cr>" },
        { "go", "<cmd>Lspsaga outline<cr>" },
        { "gd", "<cmd>Telescope coc definitions<cr>" },
        { "gt", "<cmd>Telescope coc type_definitions<cr>" },
        { "gi", "<cmd>Telescope coc implementations<cr>" },
        { "gr", "<cmd>Telescope coc references<cr>" },
        { "gl", "<cmd>lua vim.lsp.codelens.run()<cr>" },
        { "gf", "<cmd>call CocActionAsync('format')<cr>" },
        { "gn", "<Plug>(coc-diagnostic-next)" },
        { "gp", "<Plug>(coc-diagnostic-prev)" },
        { "<c-\\>", "<cmd>cclose<cr>" },
        { "<c-[>", "<cmd>cprevious<cr>" },
        { "<c-]>", "<cmd>cnext<cr>" },

        -- Ctrl + p fuzzy files
        { "<C-l>", "<nop>" },
        { "<C-c>", "<cmd>CocCommand<cr>" },
        { "<C-p>", telescope_find_files },
        { "<C-g>", "<cmd>Telescope live_grep_args<cr>" },
        -- escape clears highlighting
        { "<leader>n", "<cmd>noh<cr><esc>" },
        -- hop words
        { "s", "<cmd>HopWord<cr>" },
        { "F", "<cmd>HopLine<cr>" },
        -- yank to end of line on Y
        { "Y", "y$" },
        -- lsp mappings
        { "K", "<CMD>lua _G.show_docs()<CR>" },

        { "<leader>dd", "<cmd>call CompileRunGcc()<cr>" },

        { "ga", "<Plug>(LiveEasyAlign)" },
        { "mm", ":make<cr>" },

        -- Resize with arrows
        { "<C-Up>", ":resize -2<CR>" },
        { "<C-Down>", ":resize +2<CR>" },
        { "<C-Left>", ":vertical resize -2<CR>" },
        { "<C-Right>", ":vertical resize +2<CR>" },

        -- window management
        { "<c-j>", "<c-d>" },
        { "<c-k>", "<c-u>" },
        --
        -- window management
        { "<leader>v", "<C-w>v<C-w>l" },
        { "<leader>h", "<C-w>s<C-w>j" },
        { "<leader>;", ":Alpha<cr>" },

        --{ "n", "nzz" },
        --{ "N", "Nzz" },
        --{ "*", "*zz" },
        --{ "#", "#zz" },
        --{ "g*", "g*zz" },
        --{ "g#", "g#zz" },
        { "Q", "<cmd>q!<CR>" },
        { "<c-q>", "<cmd>qall!<CR>" },
        { "<c-s>", "<cmd>w!<CR>" },
        { "<c-q>", "<cmd>q!<CR>" },

        -- dap
        { "<M-x>", ":Telescope commands<cr>" },
        { "<M-r>", ":lua require('dap').run_last()<cr>" },
        { "<M-t>", ":lua require('dap').toggle_breakpoint()<cr>" },
        { "<M-n>", ":lua require('dap').step_over()<cr>" },
        { "<M-o>", ":lua require('dap').step_out()<cr>" },
        { "<M-i>", ":lua require('dap').step_into()<cr>" },
        { "<M-c>", ":lua require('dap').continue()<cr>" },
        { "<M-u>", ":lua require('dap').run_to_cursor()<cr>" },
        { "<M-k>", ":lua require('dapui').eval()<cr>" },

        -- bufferline
        { "<tab>", "<cmd>BufferLineCyclePrev<CR>" },
        { "<s-tab>", "<cmd>BufferLineCycleNext<CR>" },
        -- open link under cursor
        { "gx", '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>' },
    },
    t = {
        -- Terminal mode
        -- Terminal window navigation
        -- map escape to normal mode in terminal
        { "<esc>", "<C-\\><C-n>" },
        -- { "jj", [[ <C-\><C-n> ]] },
    },
    v = {
        -- Visual/Select mode
        -- Better indenting
        { "<", "<gv" },
        { ">", ">gv" },
        -- hop words
    },
    x = {
        -- remap p to always paste from last yank

        { "<leader>ga", "<Plug>(LiveEasyAlign)" },
        { "<leader>lf", "<Plug>(coc-format-selected)" },
    },
    -- "tpope/vim-rsi"
    -- has great defaults
}

register_mappings(mappings, { silent = true, noremap = true })

-- hop in motion
local actions = { "d", "c", "<", ">", "y" }
for _, a in ipairs(actions) do
    vim.keymap.set("n", a .. "f", a .. "<cmd>lua require'hop'.hint_char1()<cr>")
end

-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local map = function(type, key, value, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(type, key, value, options)
end
local opts = { silent = true, nowait = true, expr = true }
map("n", "<C-d>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-d>"', opts)
map("n", "<C-u>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-u>"', opts)
map("i", "<C-d>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Del>"', opts)
map("i", "<C-u>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<c-u>"', opts)
map("v", "<C-d>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-d>"', opts)
map("v", "<C-u>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-u>"', opts)
