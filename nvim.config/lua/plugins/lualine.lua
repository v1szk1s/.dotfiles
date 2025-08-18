return {
    'nvim-lualine/lualine.nvim',
    -- dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },

    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = false,
                theme = 'auto',
                section_separators = '',
                component_separators = '',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch' }, --, 'diff', 'diagnostics' ,
                lualine_c = { { 'filename', path = 1}, 'selectioncount' },
                lualine_x = {
                    {
                        require("noice").api.statusline.mode.get,
                        cond = require("noice").api.statusline.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    'encoding', 'fileformat', 'filetype'
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
        }
    end
}
