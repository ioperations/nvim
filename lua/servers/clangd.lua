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
end

return M
