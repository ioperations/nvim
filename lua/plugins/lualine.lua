local max_filesize = 1.5 * 1024 * 1024 -- 1.5 MB in bytes

-- Check if the current buffer is considered a massive file
local function is_large_file()
    if vim.b.coc_enabled == 0 then
        return true
    end
    local filepath = vim.api.nvim_buf_get_name(0)
    local stat = vim.uv.fs_stat(filepath)
    return (stat and stat.size > max_filesize) or false
end

local function filepath()
    -- Performance Guard: Avoid heavy string expansions on massive files
    if is_large_file() then
        return vim.fn.expand("%:t") .. " [LARGE]"
    end
    return vim.fn.expand("%:.")
end

local function project()
    return "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = true,
                component_separators = { left = "●", right = "●" },
                section_separators = "",
                disabled_filetypes = {},
                theme = vim.g.colorschema or "lunar",
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { project },
                lualine_c = {
                    {
                        filepath,
                        file_status = true,
                        path = 1,
                        color = { fg = "#ffaa88", bg = nil, gui = "" },
                    },
                    {
                        "diff",
                        cond = function()
                            return not is_large_file()
                        end, -- Bypass git scans for large files
                    },
                    {
                        "diagnostics",
                        sources = { "coc" },
                        sections = { "error", "warn", "info", "hint" },
                        symbols = { error = " ", warn = " ", info = " ", hint = "💡" },
                        diagnostics_color = {
                            error = "DiagnosticError",
                            warn = "DiagnosticWarn",
                            info = "DiagnosticInfo",
                            hint = "DiagnosticHint",
                        },
                        colored = true,
                        update_in_insert = false,
                        always_visible = false,
                        cond = function()
                            return not is_large_file()
                        end, -- Short-circuit CoC diagnostics queries
                    },
                    {
                        "b:coc_lightbulb_status",
                        "g:coc_status",
                        color = { fg = nil, gui = "" },
                        cond = function()
                            return not is_large_file()
                        end, -- Short-circuit global variable polling
                    },
                },
                lualine_x = {
                    "encoding",
                    "fileformat",
                    "filetype",
                },
                lualine_y = {
                    "branch",
                },
                lualine_z = { "progress", "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = { "fugitive" },
        },
    },
    -- bufline
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            local bufferline = require("bufferline")
            bufferline.setup({
                options = {
                    style = bufferline.style_preset.slant,
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = { "close" },
                    },
                    offsets = {
                        { filetype = "undotree", text = "Undotree", highlight = "PanelHeading", padding = 1 },
                        { filetype = "NvimTree", text = "Explorer", highlight = "PanelHeading", padding = 1 },
                        { filetype = "DiffviewFiles", text = "Diff View", highlight = "PanelHeading", padding = 1 },
                        { filetype = "flutterToolsOutline", text = "Flutter Outline", highlight = "PanelHeading" },
                        { filetype = "lazy", text = "Lazy", highlight = "PanelHeading", padding = 1 },
                        { filetype = "fugitiveblame", text = "Fugitiveblame", highlight = "PanelHeading", padding = 1 },
                    },
                    -- Note: bufferline handles diagnostics matching "coc" smoothly internally,
                    -- but will safely display nothing if `coc_enabled = 0` is set on the buffer.
                    diagnostics = "coc",
                    max_name_length = 22,
                    tab_size = 22,
                    -- Inside your bufferline.nvim setup options:
                    custom_filter = function(buf_number)
                        -- If the buffer has our performance guard flag set, hide it from bufferline calculations
                        if vim.b[buf_number].coc_enabled == 0 then
                            return false
                        end
                        return true
                    end,
                },
            })
        end,
    },
}
