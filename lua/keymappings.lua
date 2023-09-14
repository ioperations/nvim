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
        --   { "<C-h>", "<C-\\><C-N><C-w>h" },
        --   { "<C-j>", "<C-\\><C-N><C-w>j" },
        --   { "<C-k>", "<C-\\><C-N><C-w>k" },
        --   { "<C-l>", "<C-\\><C-N><C-w>l" },
        -- moving text
        --   { "<C-j>", "<esc><cmd>m .+1<CR>==" },
        --   { "<C-k>", "<esc><cmd>m .-2<CR>==" },
        -- Ctrl single quote for backtick
        { "<C-'>", "``<esc>i" },
        { "<C-p>", "<up>" },
        { "<C-n>", "<down>" },
        { "<C-a>", "<c-o>I" },
        { "<C-e>", "<c-o>A" },
        { "<C-s>", "<esc>:w<cr>" },
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
        { "gR", vim.lsp.buf.rename },
        { "gD", vim.lsp.buf.declaration },
        { "go", "<cmd>Lspsaga outline<cr>" },
        { "gd", "<Plug>(coc-definition)" },
        { "gt", "<Plug>(coc-type-definition)" },
        { "gi", "<Plug>(coc-implementation)" },
        { "gr", "<Plug>(coc-references)" },
        { "ga", "<Plug>(coc-codeaction-selected)" },
        { "gl", "<cmd>lua vim.lsp.codelens.run()<cr>" },
        { "gf", "<cmd>call CocActionAsync('format')<cr>" },
        { "gn", '<cmd>lua vim.diagnostic.goto_next({ float = { border = "rounded" } })<cr>' },
        { "gp", '<cmd>lua vim.diagnostic.goto_prev({ float = { border = "rounded" } })<cr>' },
        { "<c-\\>", "<cmd>cclose<cr>" },
        { "<c-[>", "<cmd>cprevious<cr>" },
        { "<c-]>", "<cmd>cnext<cr>" },

        -- Ctrl + p fuzzy files
        { "<C-l>", "<nop" },
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
        -- { "<C-d>", "<C-d>zz" },
        --       { "<C-u>", "<C-u>zz" },
        -- Remap for dealing with line wrap
        -- { "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, } },
        -- { "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, } },
        -- open link under cursor
        { "gx", '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>' },
    },
    t = {
        -- Terminal mode
        -- Terminal window navigation
        -- { "<C-h>", "<C-\\><C-N><C-w>h" },
        -- { "<C-j>", "<C-\\><C-N><C-w>j" },
        -- { "<C-k>", "<C-\\><C-N><C-w>k" },
        -- { "<C-l>", "<C-\\><C-N><C-w>l" },
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
        -- { "s", require("hop").hint_words },
        -- { "F", require("hop").hint_lines },
        -- moving text
        -- { "J", "<cmd>m '>+1<CR>gv=gv" },
        -- { "K", "<cmd>m '<-2<CR>gv=gv" },
    },
    x = {
        -- remap p to always paste from last yank

        { "<leader>ga", "<Plug>(LiveEasyAlign)" },
        { "<leader>lf", "<Plug>(coc-format-selected)" },
    },
    c = {
        { "<C-a>", "<Home>" },
        { "<C-b>", "<Left>" },
        { "<C-d>", "<Del>" },
        { "<C-e>", "<End>" },
        { "<C-f>", "<Right>" },
        { "<C-n>", "<Down>" },
        { "<C-j>", "<Down>" },
        { "<C-p>", "<Up>" },
        { "<C-k>", "<Up>" },
        { "<C-y>", "<C-r>*" },
        { "<C-g>", "<C-c>" },
    },
}

register_mappings(mappings, { silent = true, noremap = true })

-- S for search and replace in buffer
-- vim.cmd("nnoremap S :%s/")

-- hop in motion
local actions = { "d", "c", "<", ">", "y" }
for _, a in ipairs(actions) do
    vim.keymap.set("n", a .. "f", a .. "<cmd>lua require'hop'.hint_char1()<cr>")
end

--  local function is_lsp_float_open(window_id)
--      return window_id and window_id ~= 0 and vim.api.nvim_win_is_valid(window_id)
--  end
--
--  local function setkey(mode, origin_key, fallback_key)
--      vim.keymap.set(mode, origin_key, function()
--          assert(_G ~= nil, "_G should exists ")
--
--          local mapping = vim.api.nvim_replace_termcodes(fallback_key, true, false, true)
--          if _G._LSP_SIG_CFG == nil then
--              vim.api.nvim_feedkeys(mapping, "n" .. mode, false)
--              return
--          end
--          local window_id = _G._LSP_SIG_CFG.winnr
--          local mappingf = vim.api.nvim_replace_termcodes(origin_key, true, false, true)
--
--          if is_lsp_float_open(window_id) then
--              vim.fn.win_execute(window_id, "normal! " .. mappingf)
--          else
--              vim.api.nvim_feedkeys(mapping, "n" .. mode, false)
--          end
--      end, { silent = true })
--  end
--
--  setkey("i", "<c-d>", "<Del>")
--  setkey("i", "<c-u>", "<left>")
--
--  setkey("s", "<c-d>", "<Del>")
--  setkey("s", "<c-u>", "<left>")

local keyset = vim.keymap.set
local opts = { silent = true, nowait = true, expr = true }
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
