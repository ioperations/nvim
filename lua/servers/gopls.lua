M = {}

M.enable = function()
    require("go").setup({
        goimports = "gopls", -- if set to 'gopls' will use golsp format
        gofmt = "gopls", -- if set to gopls will use golsp format
        -- max_line_len = 120,
        tag_transform = false,
        test_dir = "",
        comment_placeholder = "",
        lsp_cfg = true, -- false: use your own lspconfig
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        lsp_keymaps = false,
        lsp_on_attach = true, -- use on_attach from go.nvim
        dap_debug = true,
    })
    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
            require("go.format").goimport()
        end,
        group = format_sync_grp,
    })
end

return M
