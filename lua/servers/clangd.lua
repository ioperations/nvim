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

M.enable = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.offsetEncoding = "utf-32"
    local navic = require("nvim-navic")

    local on_attach = function(client, bufnr)
        --   local wk = require("which-key")
        --  wk.register({
        --    l = {
        --      name = "Lsp",
        --      x = { require("rust-tools").expand_macro.expand_macro, "expand macro" },
        --    },
        --  }, { prefix = "<leader>" })
        navic.attach(client, bufnr)
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
    end

    require("lspconfig").clangd.setup({
        -- options to pass to nvim-lspconfig
        on_attach = on_attach,
        --sources = {
        --    { name = "nvim_lsp" },
        --    { name = "path" },
        --    { name = "luasnip" },
        --    { name = "cmp_tabnine" },
        --    { name = "nvim_lua" },
        --    { name = "buffer" },
        --    { name = "calc" },
        --    { name = "emoji" },
        --    { name = "treesitter" },
        --    { name = "crates" },
        --    { name = "tmux" },
        --},
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",

            "--all-scopes-completion",
            "--completion-style=detailed",
            "--offset-encoding=utf-32",
            "--enable-config",
            "--clang-tidy",
            "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
        },
        capabilities = capabilities,
        trace = "verbose",
        init_options = {
            fallbackFlags = fallbackFlags,
        },
    })

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
        end,
    }

    require("ccls").setup({
        filetypes = filetypes,
        lsp = {
            server = server_config,
            disable_capabilities = {
                completionProvider = true,
                documentFormattingProvider = true,
                documentRangeFormattingProvider = true,
                documentHighlightProvider = true,
                documentSymbolProvider = true,
                workspaceSymbolProvider = true,
                renameProvider = true,
                hoverProvider = true,
                referencesProvider = true,
                definitionProvider = true,
                codeActionProvider = true,
            },
            disable_diagnostics = true,
            disable_signature = true,
            codelens = { enable = true },
        },
    })
end

return M
