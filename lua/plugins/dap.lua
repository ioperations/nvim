return {
    {
        "leoluz/nvim-dap-go",
        config = function()
            require("dap-go").setup({
                -- Additional dap configurations can be added.
                -- dap_configurations accepts a list of tables where each entry
                -- represents a dap configuration. For more details do:
                -- :help dap-configuration
                dap_configurations = {
                    {
                        -- Must be "go" or it will be ignored by the plugin
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                    },
                },
                -- delve configurations
                delve = {
                    -- time to wait for delve to initialize the debug session.
                    -- default to 20 seconds
                    initialize_timeout_sec = 20,
                    -- a string that defines the port to start delve debugger.
                    -- default to string "${port}" which instructs nvim-dap
                    -- to start the process in a random available port
                    port = "${port}",
                },
            })
        end,
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            local Bug = ""

            --     local ArrowCircleDown = ""
            --     local ArrowCircleLeft = ""
            local ArrowCircleRight = ""
            --     local ArrowCircleUp = ""
            --     local BoldArrowDown = ""
            --     local BoldArrowLeft = ""
            --     local BoldArrowRight = ""
            --     local BoldArrowUp = ""
            local breakpoint = {
                text = Bug,
                texthl = "DiagnosticSignError",
                linehl = "",
                numhl = "",
            }
            local stopped = {
                text = ArrowCircleRight,
                texthl = "DiagnosticSignWarn",
                linehl = "Visual",
                numhl = "DiagnosticSignWarn",
            }

            vim.fn.sign_define("DapBreakpoint", breakpoint)
            vim.fn.sign_define("DapBreakpointRejected", breakpoint)
            vim.fn.sign_define("DapStopped", stopped)
            local dap = require("dap")
            dap.set_log_level("TRACE")

            local mason_root_dir = require("mason.settings").current.install_root_dir
            local lldb_path = mason_root_dir .. "/packages/codelldb/extension/adapter/codelldb"

            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    -- CHANGE THIS to your path!
                    command = lldb_path,
                    args = { "--port", "${port}" },

                    -- On windows you may have to uncomment this:
                    -- detached = false,
                },
            }

            -- FIXME: expect only one directory in /opt/homebrew/Cellar/llvm/
            local lldb_vscode_home = vim.fn.expand("/opt/homebrew/Cellar/llvm/*")

            local lldb_vscode = lldb_vscode_home .. "/bin/lldb-vscode"
            if vim.fn.filereadable(lldb_vscode) ~= 1 then
                -- check file path
                if vim.fn.executable("lldb-vscode") == 1 then
                    lldb_vscode = vim.fn.exepath("lldb-vscode")
                else
                    vim.notify("llvm-vscode should in your $PATH variable")
                end
            end

            dap.adapters.lldb_vscode = {
                type = "executable",
                command = lldb_vscode, -- adjust as needed, must be absolute path
                name = "lldb_vscode",
            }

            local OpenDebugAD7 = mason_root_dir .. "/bin/OpenDebugAD7"
            dap.adapters.cppdbg = {
                id = "cppdbg",
                type = "executable",
                command = OpenDebugAD7,
            }

            dap.configurations.cpp = {
                {
                    name = "lldb vscode Launch",
                    type = "lldb_vscode",
                    request = "launch",
                    --                   program = function()
                    --                       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    --                   end,
                    program = "${fileDirname}/${fileBasenameNoExtension}",
                    cwd = "${workspaceFolder}",
                    stopOnEntry = true,
                    args = {},
                },
                {
                    name = "lldb launch",
                    type = "codelldb",
                    request = "launch",
                    program = "${fileDirname}/${fileBasenameNoExtension}",
                    cwd = "${workspaceFolder}",
                    stopOnEntry = true,
                    args = {},
                },

                {
                    name = "lldb launch: manually program",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = true,
                    args = {},
                },
                {
                    name = "gdb launch",
                    type = "cppdbg",
                    request = "launch",
                    program = "${fileDirname}/${fileBasenameNoExtension}",
                    cwd = "${workspaceFolder}",
                    stopAtEntry = true,
                    setupCommands = {
                        {
                            text = "-enable-pretty-printing",
                            description = "enable pretty printing",
                            ignoreFailures = false,
                        },
                    },
                },
                {
                    name = "gdb launch: manually program",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtEntry = true,
                    setupCommands = {
                        {
                            text = "-enable-pretty-printing",
                            description = "enable pretty printing",
                            ignoreFailures = false,
                        },
                    },
                },

                {
                    name = "Attach to gdbserver :1234",
                    type = "cppdbg",
                    request = "launch",
                    MIMode = "gdb",
                    miDebuggerServerAddress = "localhost:1234",
                    miDebuggerPath = "/usr/bin/gdb",
                    stopAtEntry = true,
                    program = "${fileDirname}/${fileBasenameNoExtension}",
                    cwd = "${workspaceFolder}",
                    setupCommands = {
                        {
                            text = "-enable-pretty-printing",
                            description = "enable pretty printing",
                            ignoreFailures = false,
                        },
                    },
                },
                {
                    name = "Attach to gdbserver :1234: manually program",
                    type = "cppdbg",
                    request = "launch",
                    MIMode = "gdb",
                    miDebuggerServerAddress = "localhost:1234",
                    miDebuggerPath = "/usr/bin/gdb",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtEntry = true,
                    setupCommands = {
                        {
                            text = "-enable-pretty-printing",
                            description = "enable pretty printing",
                            ignoreFailures = false,
                        },
                    },
                },
            }
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp
        end,
    },
    {
        "rcarriga/nvim-dap-ui",

        config = function()
            local opt = {
                icons = { expanded = "", collapsed = "", circular = "" },
                mappings = {
                    -- Use a table to apply multiple mappings
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                -- Use this to override mappings for specific elements
                element_mappings = {},
                expand_lines = true,
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.33 },
                            { id = "breakpoints", size = 0.17 },
                            { id = "stacks", size = 0.25 },
                            { id = "watches", size = 0.25 },
                        },
                        size = 0.33,
                        position = "right",
                    },
                    {
                        elements = {
                            { id = "repl", size = 0.45 },
                            { id = "console", size = 0.55 },
                        },
                        size = 0.27,
                        position = "bottom",
                    },
                },
                controls = {
                    enabled = true,
                    -- Display controls in this element
                    element = "repl",
                    icons = {
                        pause = "",
                        play = "",
                        step_into = "",
                        step_over = "",
                        step_out = "",
                        step_back = "",
                        run_last = "",
                        terminate = "",
                    },
                },
                floating = {
                    max_height = 0.9,
                    max_width = 0.5, -- Floats will be treated as percentage of your screen.
                    border = "single", -- Border style. Can be 'single', 'double' or 'rounded'
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil, -- Can be integer or nil.
                    max_value_lines = 100, -- Can be integer or nil.
                },
            }

            local dapui = require("dapui")
            local status_ok, dap = pcall(require, "dap")
            if not status_ok then
                return
            end

            dapui.setup(opt)
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
        lazy = true,
    },
}
