local         opts = {
            options = {
                offsets = {
                    {
                        filetype = "NvimTree",
                        -- text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
                diagnostics = "coc",
                max_name_length = 22,
                tab_size = 22,
            },
        }

require('bufferline').setup(opts)


