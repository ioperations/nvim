return {
    "puremourning/vimspector",
    enabled = false,
    config = function()
        _G.vimspector_enable_mappings = "HUMAN"
        _G.vimspector_install_gadgets = { "debugpy", "vscode-cpptools", "CodeLLDB" }
        _G.vimspector_base_dir = vim.fn.expand("$HOME/.locol/share/nvim/vimspector-config")
    end,
}
