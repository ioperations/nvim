M = {}

M.enable = function()
    --    local opts = {
    --        settings = {
    --            gopls = {
    --                experimentalPostfixCompletions = true,
    --                analyses = {
    --                    unusedparams = true,
    --                    shadow = true,
    --                },
    --                staticcheck = true,
    --            },
    --        },
    --        init_options = {
    --            usePlaceholders = true,
    --        },
    --        hints = {
    --            rangeVariableTypes = true,
    --            parameterNames = true,
    --            functionTypeParameters = true,
    --            constantValues = true,
    --            compositeLiteralTypes = true,
    --            compositeLiteralFields = true,
    --            assignVariableTypes = true,
    --        },
    --    }
    --
    local cfg = require("go.lsp").config() -- config() return the go.nvim gopls setup

    require("lspconfig").gopls.setup(cfg)
end

return M
