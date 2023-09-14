local sp1 = {
    "▰▱▱▱▱▱▱▱▱▱▱▱▱▰",
    "▰▰▱▱▱▱▱▱▱▱▱▱▱▰",
    "▰▰▰▱▱▱▱▱▱▱▱▱▱▰",
    "▰▰▰▰▱▱▱▱▱▱▱▱▱▰",
    "▰▰▰▰▰▱▱▱▱▱▱▱▱▰",
    "▰▰▰▰▰▰▱▱▱▱▱▱▱▰",
    "▰▰▰▰▰▰▰▱▱▱▱▱▱▰",
    "▰▰▰▰▰▰▰▰▱▱▱▱▱▰",
    "▰▰▰▰▰▰▰▰▰▱▱▱▱▰",
    "▰▰▰▰▰▰▰▰▰▰▱▱▱▰",
    "▰▰▰▰▰▰▰▰▰▰▰▱▱▰",
    "▰▰▰▰▰▰▰▰▰▰▰▰▱▰",
    "▰▰▰▰▰▰▰▰▰▰▰▰▰▰",
    "▰▱▰▰▰▰▰▰▰▰▰▰▰▰",
    "▰▱▱▰▰▰▰▰▰▰▰▰▰▰",
    "▰▱▱▱▰▰▰▰▰▰▰▰▰▰",
    "▰▱▱▱▱▰▰▰▰▰▰▰▰▰",
    "▰▱▱▱▱▱▰▰▰▰▰▰▰▰",
    "▰▱▱▱▱▱▱▰▰▰▰▰▰▰",
    "▰▱▱▱▱▱▱▱▰▰▰▰▰▰",
    "▰▱▱▱▱▱▱▱▱▰▰▰▰▰",
    "▰▱▱▱▱▱▱▱▱▱▰▰▰▰",
    "▰▱▱▱▱▱▱▱▱▱▱▰▰▰",
    "▰▱▱▱▱▱▱▱▱▱▱▱▰▰",
    "▰▱▱▱▱▱▱▱▱▱▱▱▱▰",
}

local sp2 = {
    "▰▱▱▱▱▱▱▱▱▱▱▱▱▰",
    "▰▰▱▱▱▱▱▱▱▱▱▱▱▰",
    "▰▰▰▱▱▱▱▱▱▱▱▱▱▰",
    "▰▰▰▰▱▱▱▱▱▱▱▱▱▰",
    "▰▱▰▰▰▱▱▱▱▱▱▱▱▰",
    "▰▱▱▰▰▰▱▱▱▱▱▱▱▰",
    "▰▱▱▱▰▰▰▱▱▱▱▱▱▰",
    "▰▱▱▱▱▰▰▰▱▱▱▱▱▰",
    "▰▱▱▱▱▱▰▰▰▱▱▱▱▰",
    "▰▱▱▱▱▱▱▰▰▰▱▱▱▰",
    "▰▱▱▱▱▱▱▱▰▰▰▱▱▰",
    "▰▱▱▱▱▱▱▱▱▰▰▰▱▰",
    "▰▱▱▱▱▱▱▱▱▱▰▰▰▰",
    "▰▱▱▱▱▱▱▱▱▱▱▰▰▰",
    "▰▱▱▱▱▱▱▱▱▱▱▱▰▰",
    "▰▱▱▱▱▱▱▱▱▱▱▱▱▰",
}

return {
    {
        -- lsp server progress
        {
            "j-hui/fidget.nvim",
            branch = "legacy",
            opts = {
                window = {
                    -- border = "rounded",
                    blend = 0,
                },
                text = {
                    spinner = sp2,
                },
            },
        },
        -- status
        {
            "nvim-lua/lsp-status.nvim",
            config = function()
                require("lsp-status").config({
                    status_symbol = "  ",
                    indicator_ok = "",
                    indicator_errors = "",
                    indicator_warnings = "",
                    pinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
                })
            end,
        },

        -- winbar
        {
            "SmiteshP/nvim-navic",
            config = function()
                require("nvim-navic").setup({
                    auto_attach = false,
                })
            end,
            dependencies = {
                "nvim-web-devicons", -- optional dependency
            },
        },
        -- {
        --     "lvimuser/lsp-inlayhints.nvim",
        --     event = "LspAttach",
        --     branch = "anticonceal",
        --     opts = {},
        --     init = function()
        --         vim.api.nvim_create_autocmd("LspAttach", {
        --             group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        --             callback = function(args)
        --                 if not (args.data and args.data.client_id) then
        --                     return
        --                 end
        --                 local client = vim.lsp.get_client_by_id(args.data.client_id) or {}
        --                 ---@diagnostic disable-next-line: need-check-nil
        --                 if client.name ~= "rust_analyzer" then
        --                     return
        --                 end
        --                 require("lsp-inlayhints").on_attach(client, args.buf, false)
        --             end,
        --         })
        --     end,
        -- },
        -- rust
        {
            "rust-lang/rust.vim",
            { "simrat39/rust-tools.nvim", lazy = true },
            {
                "saecki/crates.nvim",
                version = "v0.3.0",
                dependencies = { "nvim-lua/plenary.nvim" },
                config = function()
                    require("crates").setup({
                        null_ls = {
                            enabled = true,
                            name = "crates.nvim",
                        },
                    })
                end,
            },
        },

        {
            "folke/trouble.nvim",
            config = function()
                require("trouble").setup()
            end,
        },

        { "p00f/clangd_extensions.nvim", lazy = true },
        { "ranjithshegde/ccls.nvim", lazy = true },
        -- diagnostic show
        --       {
        --           "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        --           config = function()
        --               require("lsp_lines").setup()
        --           end,
        --       },
        "jose-elias-alvarez/null-ls.nvim",
        -- code action
        {
            "weilbith/nvim-code-action-menu",
            cmd = "CodeActionMenu",
            config = function()
                vim.g.code_action_menu_window_border = "single"
            end,
            lazy = true,
        },

        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            config = function()
                require("mason-tool-installer").setup({
                    -- a list of all tools you want to ensure are installed upon
                    -- start; they should be the names Mason uses for each tool
                    ensure_installed = {

                        -- you can pin a tool to a particular version
                        -- { "golangci-lint" },
                        { "pyright" },
                        -- { "debugpy" },
                        "neocmakelsp",

                        -- you can turn off/on auto_update per tool
                        { "bash-language-server", auto_update = true },

                        "codelldb",
                        "cpptools",
                        "lua-language-server",
                        "vim-language-server",
                        -- "gopls",
                        "stylua",
                        "editorconfig-checker",
                        -- "gofumpt",
                        -- "golines",
                        -- "gomodifytags",
                        -- "gotests",
                        "impl",
                        "json-to-struct",
                        "misspell",
                        -- "revive",
                        "prettier",
                        "shellcheck",
                        "shfmt",
                        "staticcheck",
                        "vint",
                    },

                    -- if set to true this will check each tool for updates. If updates
                    -- are available the tool will be updated. This setting does not
                    -- affect :MasonToolsUpdate or :MasonToolsInstall.
                    -- Default: false
                    auto_update = true,

                    -- automatically install / update on startup. If set to false nothing
                    -- will happen on startup. You can use :MasonToolsInstall or
                    -- :MasonToolsUpdate to install tools and check for updates.
                    -- Default: true
                    run_on_start = true,

                    -- set a delay (in ms) before the installation starts. This is only
                    -- effective if run_on_start is set to true.
                    -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
                    -- Default: 0
                    start_delay = 3000, -- 3 second delay

                    -- Only attempt to install if 'debounce_hours' number of hours has
                    -- elapsed since the last time Neovim was started. This stores a
                    -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
                    -- This is only relevant when you are using 'run_on_start'. It has no
                    -- effect when running manually via ':MasonToolsInstall' etc....
                    -- Default: nil
                    debounce_hours = 1, -- at least 5 hours between attempts to install/update
                })
            end,
            dependency = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
        },
        -- lsp server manager: installation
        {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup({
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗",
                        },
                    },
                })
            end,
        },
        {
            "ray-x/go.nvim",
            dependencies = "ray-x/guihua.lua",
            lazy = true,
            config = function()
                require("go").setup({
                    lsp_cfg = false,
                })
                local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
                vim.api.nvim_create_autocmd("BufWritePre", {
                    pattern = "*.go",
                    callback = function()
                        require("go.format").goimport()
                    end,
                    group = format_sync_grp,
                })
            end,
            event = { "CmdlineEnter" },
            ft = { "go", "gomod" },
            build = ':lua require("go.install").update_all()',
        },
        -- lsp server manager: automatic setup
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason-lspconfig").setup({
                    ensure_installed = {
                        "rust_analyzer@nightly",
                        "taplo",
                        "lua_ls",
                        "clangd",
                    },
                    automatic_installation = true,
                })
                --
                -- automatic_installation is handled by lsp-manager

                require("mason-lspconfig").setup_handlers({
                    -- The first entry (without a key) will be the default handler
                    -- and will be called for each installed server that doesn't have
                    -- a dedicated handler.
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup({})
                    end,
                    -- Next, you can provide a dedicated handler for specific servers.
                    -- For example, a handler override for the `rust_analyzer`:
                    ["rust_analyzer"] = function()
                        require("servers.rust").enable()
                    end,
                    ["lua_ls"] = function()
                        require("servers.luals").enable()
                    end,
                    ["clangd"] = function()
                        require("servers.ccls").enable()
                    end,
                    ["gopls"] = function()
                        require("servers.gopls").enable()
                    end,
                    ["yamlls"] = function()
                        require("servers.yaml").enable()
                    end,
                    ["jsonls"] = function()
                        require("servers.json").enable()
                    end,
                })
            end,
            dependencies = {
                --"rcarriga/nvim-notify",
                "williamboman/mason.nvim",
                "simrat39/rust-tools.nvim",
                "b0o/SchemaStore.nvim",
                { "ranjithshegde/ccls.nvim", lazy = true },
            },
        },
    },
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("lspsaga").setup({})
        end,
    },

    -- lsp client configuration [nvim builtin lsc]
    {
        "neovim/nvim-lspconfig",
        dependencies = { "folke/neodev.nvim" },
        config = function()
            -- Setup neovim lua configuration
            require("neodev").setup()

            -- require all language server modules
            -- rounded border on :LspInfo
            require("lspconfig.ui.windows").default_options.border = "rounded"

            -- Customization and appearance -----------------------------------------
            -- change gutter diagnostic symbols
            local signs = { Error = " ", Warn = " ", Hint = "💡", Info = " " }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config({
                virtual_text = {
                    source = "if_many",
                    prefix = "💡", -- Could be '●', '▎', 'x'
                    only_current_line = true,
                },
                float = {
                    source = "always",
                },
                severity_sort = true,
            })
            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or "single"
                opts.max_width = 80
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end
            local function hover_wrapper(err, request, ctx, config)
                local fun = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
                local bufnr, winnr = fun(err, request, ctx, config)
                if bufnr == nil or winnr == nil then
                    return
                end
                local contents = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                local val = 0
                local math = require("math")
                for _, v in pairs(contents) do
                    if #v > 80 then
                        val = val + math.floor(#v / 240) + 1
                    else
                        val = val + 1
                    end
                end
                contents = vim.tbl_map(function(line)
                    return string.gsub(line, "&emsp;", "")
                end, contents)
                vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
                vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
                local height = 16
                if val < 16 then
                    height = val
                end
                vim.api.nvim_win_set_height(winnr, height + 1)

                return bufnr, winnr
            end

            local publish_diagnostics = vim.lsp.handlers["textDocument/publishDiagnostics"]

            vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
                if vim.api.nvim_get_mode().mode ~= "i" or vim.api.nvim_get_mode().mode ~= "s" then
                    -- publish_diagnostics(...)
                end
            end

            vim.lsp.handlers["textDocument/hover"] = hover_wrapper

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded",
            })
        end,
    },
}
