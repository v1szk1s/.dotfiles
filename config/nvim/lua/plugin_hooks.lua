local M = {}

function M.setup()
    local function pack_hooks(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind

        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.notify("Running :TSUpdate")
            vim.cmd("TSUpdate")
        end

        if name == "LuaSnip" and (kind == "install" or kind == "update") then
            if vim.fn.executable("make") == 1 then
                vim.notify("Running make install_jsregexp for LuaSnip")
                vim.system({ "make",  "install_jsregexp" }, { cwd = ev.data.path })
            end
        end

        if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
            if vim.fn.executable("make") == 1 then
                vim.notify("Running make for telescope-fzf-native.nvim")
                vim.system({ "make" }, { cwd = ev.data.path })
            end
        end
    end

    vim.api.nvim_create_autocmd("PackChanged", { callback = pack_hooks })
end

return M
