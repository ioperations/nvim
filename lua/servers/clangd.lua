M = {}
local llvm_version = "16"

local fallbackFlags = {
    "-L/usr/local/lib/",
    "-isystem/usr/local/include",
    "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../include/c++/v1",
    "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/14.0.3/include",
    "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include",
    "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include",
    "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks",
    "-O3",
    "-isystem/usr/local/include",
    "-isystem/opt/homebrew/opt/llvm/bin/../include/c++/v1",
    "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include",
    "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks",
    "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include",
    "-isystem/opt/homebrew/opt/llvm/" .. "/lib/clang/" .. llvm_version .. "/include",
    "-I/opt/homebrew/opt/llvm/" .. "/lib/clang/" .. llvm_version .. "/include",
    "-I/opt/homebrew/opt/llvm/" .. llvm_version .. "/include",
    "-Wall",
    "-DTEST_ADQ",
    "-Wall",
    "-Wpedantic",
    "-std=c++20",
}

if vim.fn.has("mac") == 1 then
    -- darwin: libc++ + lldb
    -- linux : libstdc++ + gdb
    table.insert(fallbackFlags, "-stdlib=libc++")
end

function nodeRequest(bufnr, method, params, handler)
    local util = require("lspconfig.util")
    bufnr = util.validate_bufnr(bufnr)
    local client = util.get_active_client_by_name(bufnr, "ccls")

    local lspHandler = function(err, result, _, _)
        if err or not result then
            vim.notify("No result from ccls", vim.log.levels.WARN, { title = "ccls navigate" })
            return
        end
        handler(result)
    end

    if client then
        client.request(method, params, lspHandler)
    else
        vim.notify("Ccls is not attached to this buffer", vim.log.levels.WARN, { title = "ccls navigate" })
    end
end

local util = require("vim.lsp.util")

function request(method, config)
    local bufnr = vim.api.nvim_get_current_buf()
    local params = {
        textDocument = {
            uri = vim.uri_from_bufnr(bufnr),
        },
        position = {
            line = vim.fn.getcurpos()[2] - 1,
            character = vim.fn.getcurpos()[3] - 1,
        },
    }
    params = vim.tbl_extend("keep", params, config)

    --    local json = require "json"
    --    print("prarm is ", json.encode(params))

    local function location_handler(result)
        if result == nil or vim.tbl_isempty(result) then
            return nil
        end

        config = { reuse_win = true, offset_encoding = "utf-32" }

        if vim.tbl_islist(result) then
            if #result == 1 then
                -- print("results[1]", json.encode(result))
                util.jump_to_location(result[1], config.offset_encoding, config.reuse_win)
            end
        end
    end
    nodeRequest(bufnr, method, params, location_handler)
end

M.enable = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.offsetEncoding = "utf-32"
    local navic = require("nvim-navic")

    -- local on_attach = function(client, bufnr)
    --     --   local wk = require("which-key")
    --     --  wk.register({
    --     --    l = {
    --     --      name = "Lsp",
    --     --      x = { require("rust-tools").expand_macro.expand_macro, "expand macro" },
    --     --    },
    --     --  }, { prefix = "<leader>" })
    --     navic.attach(client, bufnr)
    --     require("clangd_extensions.inlay_hints").setup_autocmd()
    --     require("clangd_extensions.inlay_hints").set_inlay_hints()
    -- end

    -- require("lspconfig").clangd.setup({
    --     -- options to pass to nvim-lspconfig
    --     on_attach = on_attach,
    --     cmd = {
    --         "clangd",
    --         "--background-index",
    --         "--suggest-missing-includes",
    --         "--all-scopes-completion",
    --         "--header-insertion=iwyu",
    --         "--completion-style=detailed",
    --         "--offset-encoding=utf-32",
    --         "--enable-config",
    --     },
    --     capabilities = capabilities,
    --     trace = "verbose",
    --     init_options = {
    --         fallbackFlags = fallbackFlags,
    --     },
    -- })

    local filetypes = { "c", "cpp", "objc", "objcpp", "opencl", "inc" }
    local server_config = {
        filetypes = filetypes,
        init_options = {
            cache = {
                -- directory = vim.fs.normalize("~/.cache/ccls/"),
                retainInMemory = 0,
            },
            clang = {
                --  "extraArgs": ["-DTEST_ADQ", "-Wall", "-std=c++17"]
                extraArgs = {
                    "-DTEST_ADQ",
                    "-Wall",
                    "-Wpedantic",
                    "-std=c++17",
                },
            },
        },
        name = "ccls",
        cmd = { "ccls" },
        offset_encoding = "utf-32",
        root_dir = vim.fs.dirname(
            vim.fs.find({ "compile_commands.json", "compile_flags.txt", ".git" }, { upward = true })[1]
        ),
        on_attach = function(client, bufnr)
            local wk = require("which-key")
            navic.attach(client, bufnr)
            wk.register({
                x = {
                    name = "Lsp",
                    i = { "<cmd>CclsIncomingCalls<cr>", "CCls Incoming Calls" },
                    d = { "<cmd>CclsDerived<cr>", "CCls Derived" },
                    f = { "<cmd>CclsMemberFunction<cr>", "CCls MemberFunction" },
                    D = { "<cmd>CclsDerivedHierarchy float<cr>", "CCls Derived Hierachy" },
                    o = { "<cmd>CclsOutgoingCalls<cr>", "CCls Outgoing Calls Hierachy" },
                    I = { "<cmd>CclsIncomingCallsHierarchy float<cr>", "CCls Incoming Calls Hierachy" },
                    O = { "<cmd>CclsOutgoingCallsHierarchy float<cr>", "CCls Outgoing Calls Hierachy" },
                    b = { "<cmd>CclsBase<cr>", "CCls Base" },
                    v = { "<cmd>CclsVars<cr>", "CCls Vars" },
                    m = { "<cmd>CclsMember<cr>", "CCls Member" },
                    t = { "<cmd>CclsMemberType<cr>", "CCls MemberType" },
                    B = { "<cmd>CclsBaseHierarchy float<cr>", "CCls CclsBaseHierarchy" },
                    T = { "<cmd>CclsMemberTypeHierarchy float<cr>", "CCls MemberTypeHirarchy" },
                    M = { "<cmd>CclsMemberHierarchy float<cr>", "CCls MemberHirarchy" },
                    F = { "<cmd>CclsMemberFunctionHierarchy float<cr>", "CCls MemberFunctionHierarchy" },
                },
            }, { prefix = "<leader>" })

            local cmd = vim.api.nvim_create_user_command

            local navigate = function(direction)
                if type(direction) ~= "string" then
                    error("CclsNavigate expect D/R/L/U as params")
                    if direction ~= "D" or direction ~= "R" or direction ~= "L" or direction ~= "U" then
                        error("CclsNavigate expect D/R/L/U as params")
                    end
                    return
                end
                request("$ccls/navigate", { direction = direction })
            end

            cmd("CclsNavigate", function(opts)
                navigate(opts.args)
            end, { nargs = "*", desc = "ccls Navigation" })

            _G.create_ccls_keymap = function()
                local buf_number = vim.api.nvim_get_current_buf()
                vim.api.nvim_buf_set_keymap(buf_number, "n", "<c-l>", "<cmd>CclsNavigate D<cr>", {})
                vim.api.nvim_buf_set_keymap(buf_number, "n", "<c-k>", "<cmd>CclsNavigate L<cr>", {})
                vim.api.nvim_buf_set_keymap(buf_number, "n", "<c-j>", "<cmd>CclsNavigate R<cr>", {})
                vim.api.nvim_buf_set_keymap(buf_number, "n", "<c-h>", "<cmd>CclsNavigate U<cr>", {})
            end

            vim.api.nvim_create_augroup("CclsGroup", {})
            vim.api.nvim_create_autocmd("FileType", {
                group = "CclsGroup",
                pattern = { "c", "cpp", "objc", "objcpp" },
                command = "v:lua.create_ccls_keymap()",
                desc = "Create ccls keymap",
            })

            create_ccls_keymap()
        end,
    }

    require("ccls").setup({
        filetypes = filetypes,
        lsp = {
            server = server_config,
            disable_capabilities = {
                completionProvider = false,
                documentFormattingProvider = false,
                documentRangeFormattingProvider = false,
                documentHighlightProvider = false,
                documentSymbolProvider = false,
                workspaceSymbolProvider = false,
                renameProvider = false,
                hoverProvider = false,
                referencesProvider = false,
                definitionProvider = false,
                codeActionProvider = false,
            },
            disable_diagnostics = false,
            disable_signature = false,
            codelens = { enable = true },
        },
    })
end

return M
