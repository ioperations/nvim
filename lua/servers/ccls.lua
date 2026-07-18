M = {}
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

local function custom_jump_to_location(target, offset_encoding, reuse_win)
    reuse_win = reuse_win or {}
    local uri = target.uri or target.targetUri
    local range = target.range or target.targetSelectionRange

    if not uri or not range then
        return false
    end

    -- 1. Convert URI to a buffer number
    local bufnr = vim.uri_to_bufnr(uri)

    -- 2. Ensure the buffer is loaded into memory
    if not vim.api.nvim_buf_is_loaded(bufnr) then
        vim.fn.bufload(bufnr)
    end

    -- 3. Handle window switching (reuse_win logic)
    local win = vim.api.nvim_get_current_win()
    if reuse_win then
        -- Find if this buffer is already open in any window of the current tab
        local wins = vim.api.nvim_tabpage_list_wins(0)
        for _, w in ipairs(wins) do
            if vim.api.nvim_win_get_buf(w) == bufnr then
                win = w
                break
            end
        end
    end

    -- 4. Switch to the target window and set the target buffer
    vim.api.nvim_set_current_win(win)
    vim.api.nvim_win_set_buf(win, bufnr)

    -- 5. Set the cursor position (LSP lines/chars are 0-indexed)
    local line = range.start.line
    local col = range.start.character

    -- nvim_win_set_cursor expects a 1-indexed line and 0-indexed column
    pcall(vim.api.nvim_win_set_cursor, win, { line + 1, col })

    return true
end

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

        if vim.islist(result) then
            if #result == 1 then
                -- print("results[1]", vim.inspect(result))
                custom_jump_to_location(result[1], config.offset_encoding, config.reuse_win)
            end
        end
    end
    nodeRequest(bufnr, method, params, location_handler)
end

M.enable = function()
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
                extraArgs = {},
            },
            codeLens = {
                localVariables = false,
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
                    c = { "<cmd>CclsIncomingCalls<cr>", "CCls caller" },
                    C = { "<cmd>CclsOutgoingCalls<cr>", "CCls callee" },
                    d = { "<cmd>CclsDerived<cr>", "CCls Derived" },
                    s = { "<cmd>CclsMember 2<cr>", "CCls Member nested calsses/namespace members" },
                    f = { "<cmd>CclsMember 3<cr>", "CCls Member functions" },
                    m = { "<cmd>CclsMember 0<cr>", "CCls Member variables" },
                    D = { "<cmd>CclsDerivedHierarchy float<cr>", "CCls Derived Hierachy" },
                    o = { "<cmd>CclsOutgoingCalls<cr>", "CCls Outgoing Calls Hierachy" },
                    I = { "<cmd>CclsIncomingCallsHierarchy float<cr>", "CCls Incoming Calls Hierachy" },
                    O = { "<cmd>CclsOutgoingCallsHierarchy float<cr>", "CCls Outgoing Calls Hierachy" },
                    b = { "<cmd>CclsBase<cr>", "CCls Base" },
                    v = { "<cmd>CclsVars 3<cr>", "CCls Vars; field or local variable" },
                    V = { "<cmd>CclsVars 1<cr>", "CCls Vars; field" },
                    W = { "<cmd>CclsVars 7<cr>", "CCls Vars; field" },
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

    if not vim.fn.exists(vim.fn.glob(vim.fn.getcwd() .. "/compile_commands.json")) then
        local fallback = {
            "-DTEST_ADQ",
            "-Wall",
            "-Wpedantic",
            "-std=c++17",
        }
        server_config.init_options.clang.extraArgs = fallback
    end

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
