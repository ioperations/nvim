return {
    -- {
    --     "github/copilot.vim",
    --     config = function()
    --         vim.api.nvim_exec(
    --             [[
    --                 imap <silent><script><expr> <C-]> copilot#Accept("\<CR>")
    --                 let g:copilot_no_tab_map = v:true
    --                 ]],
    --             false
    --         )
    --     end,
    --     lazy = false,
    -- },

    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("lspsaga").setup({})
        end,
    },
    -- autopirs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    {
        "tamago324/nlsp-settings.nvim",
        dependencies = "williamboman/nvim-lsp-installer",
        config = function()
            local lsp_installer = require("nvim-lsp-installer")
            local lspconfig = require("lspconfig")
            local nlspsettings = require("nlspsettings")
            nlspsettings.setup({
                config_home = vim.fn.expand("$HOME") .. "/.config/nvim/nlsp-settings",
                local_settings_dir = ".nlsp-settings",
                local_settings_root_markers_fallback = { ".git" },
                append_default_schemas = true,
                loader = "json",
            })

            function on_attach(client, bufnr)
                local function buf_set_option(...)
                    vim.api.nvim_buf_set_option(bufnr, ...)
                end
                buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
            end

            local global_capabilities = vim.lsp.protocol.make_client_capabilities()
            global_capabilities.textDocument.completion.completionItem.snippetSupport = true

            lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
                capabilities = global_capabilities,
            })

            lsp_installer.on_server_ready(function(server)
                server:setup({
                    on_attach = on_attach,
                })
            end)
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lua", -- nvim config completions
            "saadparwaiz1/cmp_luasnip", -- snippets completions
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            {
                "onsails/lspkind-nvim",
                config = function()
                    local lspkind = require("lspkind")
                    lspkind.init({
                        symbol_map = {
                            Copilot = "",
                        },
                    })

                    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
                end,
            },
            -- "hrsh7th/cmp-nvim-lsp-signature-help",
            -- { "tzachar/cmp-fuzzy-buffer", dependencies = { "tzachar/fuzzy.nvim" } },
            -- {
            --     "roobert/tailwindcss-colorizer-cmp.nvim",
            --     config = function()
            --         require("tailwindcss-colorizer-cmp").setup({
            --             color_square_width = 2,
            --         })
            --     end,
            -- }, -- tailwind color in suggesions
        },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")

            local lspkind = require("lspkind")
            local luasnip = require("luasnip")

            -- html snippets in javascript and javascriptreact
            luasnip.filetype_extend("javascriptreact", { "html" })
            luasnip.filetype_extend("typescriptreact", { "html" })

            local loader = require("luasnip/loaders/from_snipmate")
            loader.lazy_load()

            loader.lazy_load({ path = vim.fn.expand("$HOME") .. "/.config/nvim/snippets/" })

            require("luasnip/loaders/from_vscode").lazy_load()

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local compare = require("cmp.config.compare")
            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol",
                        ellipsis_char = "...",
                        maxwidth = 50,
                        before = function(entry, vim_item)
                            vim_item.abbr = string.gsub(vim_item.abbr, "^%s+", "")
                            -- vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
                            return vim_item
                        end,
                    }),
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<C-k>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        elseif cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "c", "s" }),
                    ["<C-j>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif cmp.visible() then
                            cmp.select_next_item()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "c", "s" }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            -- cmp.complete()
                            fallback()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),

                    ["<C-c>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({
                        -- behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }),
                },
                sources = cmp.config.sources({
                    { name = "luasnip", priority = 45 },
                    { name = "nvim_lsp", priority = 20 },
                    {
                        name = "buffer",
                        option = {
                            keyword_pattern = [[\k\+]],
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs()
                            end,
                        },
                    },
                    { name = "path" },
                    { name = "emoji" },
                }),
                experimental = {
                    ghost_text = true,
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        compare.locality,
                        compare.score,
                        compare.kind,
                        compare.recently_used,
                        compare.exact,
                        compare.offset,
                        compare.sort_text,
                        compare.length,
                        compare.order,
                        -- require("cmp_fuzzy_buffer.compare"),
                    },
                },
            })

            -- only enable nvim_lsp in lua files
            vim.cmd(
                [[ autocmd FileType lua lua require'cmp'.setup.buffer { sources = { { name = 'buffer' },{ name = 'nvim_lua'},{name = "nvim_lsp"}, {name = 'path'}, {name = 'emoji'}},} ]]
            )

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "buffer" },
                    -- { name = "fuzzy_buffer" },
                }),
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" },
                }),
            })
        end,
    },
}
