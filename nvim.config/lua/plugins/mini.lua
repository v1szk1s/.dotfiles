return {
    'echasnovski/mini.nvim',
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup { n_lines = 50 }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)

        -- local statusline = require 'mini.statusline'
        -- statusline.setup()

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we disable the section for
        -- cursor information because line numbers are already enabled
        -- ---@diagnostic disable-next-line: duplicate-set-field
        -- statusline.section_location = function()
        --     return ''
        -- end

        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
    end,
}
