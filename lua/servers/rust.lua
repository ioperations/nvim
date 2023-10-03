M = {}

M.enable = function()
    local codelldb_path
    local liblldb_path

    local mason_root_dir = require("mason.settings").current.install_root_dir
    local extension_path = mason_root_dir .. "/packages/codelldb/extension/"
    codelldb_path = extension_path .. "adapter/codelldb"

    if vim.fn.empty(vim.fn.glob(codelldb_path)) ~= 0 then
        -- codelldb is not exists
        local async = require("plenary.async")

        async.run(function()
            vim.notify(" 🦀 using :MasonInstall codelldb to install codelldb")
            -- vim.cmd("MasonInstall codelldb")
        end)
    end

    if vim.fn.has("mac") == 1 then
        liblldb_path = extension_path .. "lldb/lib/liblldb.dylib" -- MacOS: This may be .dylib
    else
        liblldb_path = extension_path .. "lldb/lib/liblldb.so"
    end

    -- local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
    -- local codelldb_adapter = {
    --   type = "server",
    --   port = "${port}",
    --   executable = {
    --     command = mason_path .. "bin/codelldb",
    --     args = { "--port", "${port}" },
    --   },
    -- }

    vim.g.cargo_run_current_test = "cargo test"

    local M = {}
    function M.execute_command(command, args, _)
        local args_flatten = " "
        for _, v in pairs(args) do
            args_flatten = args_flatten .. " "
            args_flatten = args_flatten .. v
        end

        local com = command .. args_flatten
        local running = "!" .. com
        vim.g.cargo_run_current_test = com

        vim.cmd("set makeprg=cargo")

        vim.cmd(running)
    end
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- local ih = require("lsp-inlayhints")
    pcall(function()
        require("rust-tools").setup({
            tools = {
                -- executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
                executor = M,
                reload_workspace_from_cargo_toml = true,
                runnables = {
                    use_telescope = true,
                },
                inlay_hints = {
                    auto = false,
                    only_current_line = false,
                    show_parameter_hints = true,
                    only_current_line_autocmd = "CursorHold",
                    show_variable_name = true,
                    parameter_hints_prefix = "<-",
                    other_hints_prefix = "=>",
                    max_len_align = false,
                    max_len_align_padding = 1,
                    right_align = false,
                    right_align_padding = 7,
                    highlight = "Comment",
                },
                hover_actions = {
                    border = {
                        { "╭", "FloatBorder" },
                        { "─", "FloatBorder" },
                        { "╮", "FloatBorder" },
                        { "│", "FloatBorder" },
                        { "╯", "FloatBorder" },
                        { "─", "FloatBorder" },
                        { "╰", "FloatBorder" },
                        { "│", "FloatBorder" },
                    },
                },
                on_initialized = function()
                    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                        pattern = { "*.rs" },
                        callback = function()
                            local _, _ = pcall(vim.lsp.codelens.refresh)

                            -- ih.show()
                        end,
                    })
                end,
            },
            dap = {
                adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            },
            server = {
                on_attach = function(client, bufnr)
                    local wk = require("which-key")
                    wk.register({
                        l = {
                            name = "Lsp",
                            x = { require("rust-tools").expand_macro.expand_macro, "expand macro" },
                        },
                    }, { prefix = "<leader>" })

                    if client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_del_augroup_by_name(vim.fn.printf("lsp_document_highlight_%d", bufnr))
                    end
                    -- ih.show()
                end,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        lens = {
                            enable = true,
                            debug = { enable = true },
                            forceCustomCommands = true,
                            implementations = { enable = true },
                            location = "above_name",
                            references = {
                                adt = { enable = true },
                                enumVariant = { enable = true },
                                method = { enable = true },
                                trait = { enable = true },
                            },
                            run = { enable = true },
                        },
                        imports = {
                            granularity = {
                                group = "module",
                            },
                            prefix = "self",
                        },
                        cargo = {
                            buildScripts = {
                                enable = true,
                            },
                        },
                        procMacro = {
                            enable = true,
                        },
                        diagnostics = {
                            disabled = { "unresolved-proc-macro" },
                            experimental = {
                                enable = true,
                            },
                        },
                        checkOnSave = {
                            enable = true,
                            command = "clippy",
                        },
                    },
                },
            },
        })
    end)
end

return M
