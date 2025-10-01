M = {}

M.enable = function()
    vim.lsp.config.yamlls.settings = {
        yaml = {
            hover = true,
            format = {
                printWidth = 80,
                enable = true,
            },
            completion = true,
            validate = true,
            keyOrdering = false,
            maxItemsComputed = 1000000000,
            schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = require("schemastore").yaml.schemas(),
        },
    }
end

return M
