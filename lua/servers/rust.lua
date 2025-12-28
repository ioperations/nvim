M = {}

M.enable = function()
    local codelldb_path
    local liblldb_path

    local mason_root_dir = require("mason.settings").current.install_root_dir
    local extension_path = mason_root_dir .. "/packages/codelldb/extension/"
    codelldb_path = extension_path .. "adapter/codelldb"
    local async = require("plenary.async")

    if vim.fn.empty(vim.fn.glob(codelldb_path)) ~= 0 then
        -- codelldb is not exists

        async.run(function()
            vim.notify(" 🦀 using :MasonInstall codelldb to install codelldb")
            -- vim.cmd("MasonInstall codelldb")
        end, function() end)
    end
    --  if vim.fn.executable("ra-multiplex") == 0 then
    --      async.run(function()
    --          vim.notify(" 🦀:ra-multiplex not exists, please install it by `cargo install ra-multiplex`")
    --          -- vim.cmd("MasonInstall codelldb")
    --      end, function() end)
    --  end

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
    return {
        tools = {
            -- executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
            executor = M,
            reload_workspace_from_cargo_toml = true,
            runnables = {
                use_telescope = true,
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
            adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
            cmd = { vim.fn.expand("$HOME") .. "/.cargo/bin/rust-analyzer" },
            on_attach = function(client, bufnr)
                local wk = require("which-key")
                wk.register({
                    l = {
                        name = "Lsp",
                        x = { require("rustaceanvim").expand_macro, "expand macro" },
                    },
                }, { prefix = "<leader>" })
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
                    inlayhints = {
                        typeHints = {
                            enable = false,
                        },
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
    }
end

return M
