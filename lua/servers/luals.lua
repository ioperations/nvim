-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#sumneko_lua
M = {}

M.enable = function()
    require("lspconfig").lua_ls.setup({
        settings = {
            Lua = {
                hint = { enable = true },
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    checkThirdParty = false,
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },

        on_attach = function(client, bufnr)
            vim.lsp.inlay_hint.enable()
        end,
    })
end

return M
