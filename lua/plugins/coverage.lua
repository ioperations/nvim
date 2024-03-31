return {
    "andythigpen/nvim-coverage",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
        require("coverage").setup({
            commands = true, -- create commands
            auto_reload = true,
            highlights = {
                -- customize highlight groups created by the plugin
                covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
                uncovered = { fg = "#F07178" },
            },
            signs = {
                -- use your own highlight groups or text markers
                covered = { hl = "CoverageCovered", text = "▎" },
                uncovered = { hl = "CoverageUncovered", text = "▎" },
            },
            summary = {
                -- customize the summary pop-up
                min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
                width_percentage = 0.8,
                height_percentage = 0.8,
            },
            lang = {
                -- customize language specific settings
                cpp = {
                    coverage_file = "lcov.info",
                },
            },
        })
    end,
}
