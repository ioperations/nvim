return {
    {
        "IngoMeyer441/coc_current_word",
        dependencies = {
            "neoclide/coc.nvim",
            "lunarvim/lunar.nvim",
        },
        config = function()
            vim.g.coc_current_word_highlight_delay = 10
            vim.api.nvim_exec2([[hi CurrentWord guifg=None guibg=#3b5e6a gui=underline,bold]], {})
            vim.api.nvim_exec2([[highlight ColorColumn guibg=#161616]], {})
            vim.api.nvim_exec2([[highlight CocSemTypeParameter guifg=#FF6600 gui=underline]], {})
            vim.api.nvim_exec2([[highlight CocSemTypeVariable guifg=#FFCC33 ]], {})
            -- vim.api.nvim_exec2([[highlight CocSemTypeFunction guifg=#52A3D3 ]], {})
        end,
    },
    {
        "neoclide/coc.nvim",
        branch = "release",
        -- dependencies = { "ahmedkhalf/project.nvim" },
        config = function()
            vim.g.coc_terminal_height = 20
            vim.g.coc_global_extensions = {
                "coc-jedi",
                "coc-rust-analyzer",
                "coc-jedi",
                "coc-pyright",
                "coc-vimlsp",
                "coc-html",
                "coc-json",
                "coc-css",
                "coc-tsserver",
                "coc-yank",
                "coc-gitignore",
                "coc-lists",
                "coc-git",
                "coc-flutter",
                "coc-todolist",
                "coc-tasks",
                "coc-snippets",
                "coc-yaml",
                "coc-go",
                "coc-git",
                "coc-clangd",
                "coc-emoji",
                -- "coc-highlight",
                "coc-pairs",
                "coc-lightbulb",
                "coc-prettier",
            }
            -- Always show the signcolumn, otherwise it would shift the text each time
            -- diagnostics appeared/became resolved

            local keyset = vim.keymap.set
            -- Autocomplete
            function _G.check_back_space()
                local col = vim.fn.col(".") - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
            end

            -- Use Tab for trigger completion with characters ahead and navigate
            -- NOTE: There's always a completion item selected by default, you may want to enable
            -- no select by setting `"suggest.noselect": true` in your configuration file
            -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
            -- other plugins before putting this into your config
            local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
            keyset(
                "i",
                "<TAB>",
                'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
                opts
            )
            keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

            -- Make <CR> to accept selected completion item or notify coc.nvim to format
            -- <C-g>u breaks current undo, please make your own choice
            keyset(
                "i",
                "<cr>",
                [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
                opts
            )

            -- Use <c-j> to trigger snippets
            keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
            -- Use <c-space> to trigger completion
            keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

            -- Use `[g` and `]g` to navigate diagnostics
            -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list

            local setup_lsp_server = function()
                local mason_root_dir = require("mason.settings").current.install_root_dir

                local language_server_config = vim.json.encode({
                    lua_language_server = {
                        settings = {
                            Lua = {
                                hint = { enable = "true" },
                                workspace = {
                                    maxPreload = 2000,
                                    preloadFileSize = 1000,
                                    checkThirdParty = "false",
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
                                runtime = {
                                    version = "LuaJIT",
                                },
                                filetypes = { "lua" },
                                diagnostics = {
                                    enable = "true",
                                    globals = {
                                        "vim",
                                        "setup",
                                    },
                                    disable = { "lowercase-global" },
                                },
                                completion = {
                                    keywordSnippet = "Disable",
                                },
                                telemetry = {
                                    enable = "false",
                                },
                            },
                        },
                        command = mason_root_dir .. "/bin/lua-language-server",
                        filetypes = { "lua" },
                    },
                    cmake_language_server = {
                        command = mason_root_dir .. "/bin/neocmakelsp",
                        filetypes = { "cmake" },
                        rootPatterns = { ".git" },
                        args = { "stdio" },
                        initializationOptions = {
                            buildDirectory = "build",
                        },
                    },
                    bash_language_server = {
                        command = mason_root_dir .. "/bin/bash-language-server",
                        filetypes = { "bash", "sh", "zsh" },
                        args = { "start" },
                        ignoredRootPaths = {},
                    },
                    java_langauge_server = {
                        command = mason_root_dir .. "/bin/jdtls",
                        filetypes = { "java" },
                        args = {},
                    },
                })

                language_server_config = string.gsub(language_server_config, '"', "'")
                language_server_config = string.gsub(language_server_config, "\\", "")
                -- vim.print(vim.inspect(language_server_config))
                local vim_config = "call coc#config('languageserver'," .. language_server_config .. ")"
                -- print(vim_config)
                vim.api.nvim_exec2(vim_config, {})
            end

            setup_lsp_server()

            -- Use K to show documentation in preview window
            function _G.show_docs()
                local cw = vim.fn.expand("<cword>")
                if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
                    vim.api.nvim_command("h " .. cw)
                elseif vim.tbl_contains({ "man" }, vim.bo.filetype) then
                    vim.cmd("Man " .. cw)
                elseif vim.fn.expand("%:t") == "Cargo.toml" then
                    require("crates").show_popup()
                elseif vim.api.nvim_eval("coc#rpc#ready()") then
                    vim.fn.CocActionAsync("doHover")
                else
                    vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
                end
            end

            -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
            vim.api.nvim_create_augroup("CocGroup", {})
            -- inlay hint got highlight when using Coc's highlight setting
            ---

            local max_filesize = 1.5 * 1024 * 1024 -- 1.5 MB threshold
            local coc_guard_group = vim.api.nvim_create_augroup("CocPerformanceGuard", { clear = true })

            vim.api.nvim_create_autocmd("BufReadPre", {
                group = coc_guard_group,
                pattern = "*",
                callback = function(ev)
                    local filepath = ev.match
                    local stat = vim.uv.fs_stat(filepath)

                    -- If the file exists and is larger than our max threshold
                    if stat and stat.size > max_filesize then
                        -- 1. Kill CoC for this buffer entirely
                        vim.b[ev.buf].coc_enabled = 0

                        -- 2. Performance bonus: turn off heavy features for this buffer
                        vim.opt_local.syntax = "off"
                        vim.opt_local.undofile = false
                        vim.opt_local.swapfile = false

                        -- Optional visual indicator so you know why features are off
                        vim.schedule(function()
                            vim.notify(
                                "Large file detected: Disabling CoC and syntax highlighting for performance.",
                                vim.log.levels.WARN
                            )
                        end)
                    end
                end,
                desc = "Disable CoC and heavy buffers features globally for large files.",
            })

            vim.api.nvim_create_autocmd("CursorHold", {
                group = "CocGroup",
                callback = function(ev)
                    -- 1. Performance Guard: If CoC is disabled for this buffer (e.g., large files), do nothing
                    if vim.b[ev.buf].coc_enabled == 0 then
                        return
                    end

                    -- 2. Performance Guard: Double-check file size just in case
                    local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(ev.buf))
                    if stat and stat.size > max_filesize then
                        return
                    end

                    -- 3. Defer the async call to the next event loop tick to prevent UI blocking
                    vim.schedule(function()
                        -- Verify the buffer is still valid before calling the action
                        if vim.api.nvim_buf_is_valid(ev.buf) then
                            vim.fn.CocActionAsync("highlight")
                        end
                    end)
                end,
                desc = "Highlight symbol under cursor safely on CursorHold.",
            })

            -- Formatting selected code
            keyset("x", "<leader>lf", "<Plug>(coc-format-selected)", { silent = true })

            -- Setup formatexpr specified filetype(s)
            vim.api.nvim_create_autocmd("FileType", {
                group = "CocGroup",
                pattern = { "typescript", "json" }, -- Native Lua table pattern
                callback = function(ev)
                    if vim.b[ev.buf].coc_enabled == 0 then
                        return
                    end

                    local filepath = vim.api.nvim_buf_get_name(ev.buf)
                    local stat = vim.uv.fs_stat(filepath)

                    -- If the file is larger than 1MB, kill CoC for this buffer and exit
                    if stat and stat.size > max_filesize then
                        vim.b[ev.buf].coc_enabled = 0
                        vim.opt_local.syntax = "off" -- Disabling heavy syntax highlighting also boosts performance
                        return
                    end

                    -- Otherwise, safely apply your formatting rule
                    vim.opt_local.formatexpr = "CocAction('formatSelected')"
                end,
                desc = "Setup formatexpr safely for normal sized typescript/json files.",
            })

            -- Update signature help on jump placeholder
            vim.api.nvim_create_autocmd("User", {
                group = "CocGroup",
                pattern = "CocJumpPlaceholder",
                callback = function(ev)
                    if vim.b[ev.buf].coc_enabled == 0 then
                        return
                    end
                    -- Using schedule wraps the execution safely out of the fast input loop
                    -- to prevent blocking the UI during rapid snippet jumping
                    vim.schedule(function()
                        vim.fn.CocActionAsync("showSignatureHelp")
                    end)
                end,
                desc = "Update signature help asynchronously on jump placeholder safely.",
            })

            -- Apply codeAction to the selected region
            -- Example: <leader>aap` for current paragraph
            opts = { silent = true, nowait = true }
            keyset("x", "<leader>la", "<Plug>(coc-codeaction-selected)", opts)

            -- Remap keys for apply code actions at the cursor position.
            keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
            -- Remap keys for apply source code actions for current file.
            keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
            -- Apply the most preferred quickfix action on the current line.
            keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

            -- Remap keys for apply refactor code actions.
            keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
        end,
    },
}
