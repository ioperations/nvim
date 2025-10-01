M = {}

M.enable = function()
    vim.lsp.config.jsonls.settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    }
end
return M
