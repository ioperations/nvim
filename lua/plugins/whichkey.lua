return {
    {
        "folke/which-key.nvim",
        opts = {
            plugins = {
                spelling = {
                    enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                    suggestions = 20, -- how many suggestions should be shown in the list?
                },
            },
            window = {
                border = "single", -- none, single, double, shadow
                position = "bottom", -- bottom, top
                margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
                padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
                -- winblend = 0,
            },
            triggers_blacklist = {
                -- list of mode / prefixes that should never be hooked by WhichKey
                -- this is mostly relevant for key maps that start with a native binding
                -- most people should not need to change this
                i = { "j", "k" },
                v = { "j", "k" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            -- register key bindings with <leader> prefix
            wk.register({
                f = {
                    -- mostly Telescope bindings
                    name = "Find with Telescope",
                    f = { [[<cmd> lua require"telescope.builtin".find_files({ hidden = true })<CR>]], "Find File" },
                    b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
                    n = { "<cmd>TodoTelescope<cr>", "Find Notes" },
                    t = { "<cmd>Telescope builtin<cr>", "Telescope builtin" },
                    s = { "<cmd>Telescope live_grep_args<cr>", "Rg" },
                    r = { "<cmd>Telescope lsp_references<cr>", "Find References" },
                    d = { "<cmd>Telescope diagnostics<cr>", "Document Diagnostics" },
                    m = { "<cmd>Telescope marks<CR>", "Marks" },
                    l = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Line find" },
                    k = { "<cmd>Telescope keymaps<CR>", "Key mappings" },
                    M = { "<cmd>Telescope man_pages<CR>", "Man pages" },
                    a = { "<cmd>Telescope session-lens search_session<CR>", "Search Sessions" },
                    h = { "<cmd>Telescope help_tags<CR>", "Search help" },
                    j = { "<cmd>Telescope jumplist<CR>", "jumplist help" },
                    T = { "<cmd>TodoTelescope<CR>", "Search Todos" },
                    e = { "<cmd>Telescope file_browser<CR>", "Browse Files" },
                    q = { "<cmd>Telescope quickfix<CR>", "quickfix fuzzy find" },
                },
                e = { "<cmd>NvimTreeToggle<CR>", "File Tree" },
                p = { "<cmd>Zi<cr>", "go to path" },
                u = { "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>", "Undotree" },
                L = { "<cmd>Lazy<CR>", "Lazy" },
                M = { "<cmd>Mason<CR>", "Mason" },
                -- x = { "<cmd>Copilot panel<CR>", "Copy line" },
                -- trouble bindings
                t = {
                    name = "Trouble",
                    t = { "<cmd>FloatermNew --width=0.9 --height=0.9 <CR>", "Toggle terminal" },
                    r = { "<cmd>Trouble lsp_references<CR>", "References" },
                    d = { "<cmd>Trouble lsp_definitions<CR>", "Definitions" },
                    q = { "<cmd>Trouble quickfix<CR>", "Quickfix" },
                    T = { "<cmd>TodoTrouble<CR>", "Todos" },
                    w = { "<cmd>Trouble workspace_diagnostics<CR>", "Workspace Diagnostics" },
                    D = { "<cmd>Trouble document_diagnostics<CR>", "Document Diagnostics" },
                },
                d = {
                    o = { require("dapui").toggle, "debug ui toggle" },
                },
                r = { r = { "<cmd>FloatermNew --width=0.9 --height=0.9 ranger<cr>", "ranger" } },
                R = { "<cmd>Telescope resume<cr>", "resume" },
                -- Bufferline
                g = {
                    a = { "<cmd>Git add .<cr>", "Git add" },
                    c = { "<cmd>Git commit<cr>", "Git commit" },
                    d = { "<cmd>Gdiffsplit<cr>", "Git Diff" },
                    b = { "<cmd>Git blame<cr>", "Git blame" },
                    p = { "<cmd>Git push<cr>", "Git push" },
                    g = { "<cmd>LazyGit<cr>", "LazyGit" },
                    s = { "<cmd>Git status<cr>", "Git status" },
                    P = { "<cmd>Git pull<cr>", "Git pull" },
                    m = { require("gitsigns").blame_line, "git message" },
                },
                l = {
                    name = "LSP",
                    f = { "<cmd>call CocActionAsync('format')<cr>", "Format File" },
                    R = { "<Plug>(coc-rename)", "Rename" },
                    D = { vim.lsp.buf.declaration, "declaration" },
                    d = { "<cmd>Telescope lsp_definitions<cr>", "Definition" },
                    r = { "<cmd>Telescope lsp_references<cr>", "References" },
                    a = { "<Plug>(coc-codeaction-selected)", "codeAction" },
                    o = { "<cmd>Lspsaga outline<cr>", "Outline" },
                    i = { "<cmd>Telescope lsp_implementations<cr>", "Implementations" },
                    l = { "<Plug>(coc-codelens-action)", "Run codelens" },
                    t = { "<cmd>Telescope lsp_type_definitions<cr>", "Type Definition" },
                    n = { "<Plug>(coc-diagnostic-next)", "next error" },
                    p = { "<Plug>(coc-diagnostic-prev)", "next error" },
                },
            }, {
                prefix = "<leader>",
            })
        end,
    },
}
