require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    ensure_installed = {
        "cpp",
        "c",
        "tsx",
        "toml",
        "fish",
        "php",
        "rust",
        "go",
        "python",
        "java",
        "json",
        "yaml",
        "swift",
        "html",
        "scss"
    },
}
