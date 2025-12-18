vim.pack.add({
  {
    src = "https://www.github.com/nvim-treesitter/nvim-treesitter",
    version = "master",
  },
})

local function pack_hooks(ev)
  local name = ev.data.spec.name
  local kind = ev.data.kind

  if name == "LuaSnip" and (kind == "install" or kind == "update") then
    vim.cmd("TSUpdate")
  end
end

vim.api.nvim_create_autocmd("PackChanged", { callback = pack_hooks })

vim.cmd("packadd nvim-treesitter")

require('nvim-treesitter').install({ 'go', 'javascript', 'typescript', 'html', 'lua' })
