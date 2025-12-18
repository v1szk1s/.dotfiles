-- vim.pack.add({
--   'https://www.github.com/nvim-treesitter/nvim-treesitter',
-- })
--
--
-- vim.api.nvim_create_autocmd("PackChanged", {
--   callback = function(ev)
--     if ev.data.spec.name == "nvim-treesitter" and (ev.data.kind == "install" or ev.data.kind == "update") then
--       vim.cmd.packadd("nvim-treesitter")
--       vim.cmd("silent! TSUpdate")
--     end
--   end,
-- })
--
-- require('nvim-treesitter').install({ 'go', 'javascript', 'typescript' })

-- Treesitter via :h vim.pack.add (Neovim 0.12)
local ts = vim.pack.add({
  {
    name = "nvim-treesitter",
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
  },
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local data = ev.data or {}
    local spec = data.spec or {}
    if spec.name ~= "nvim-treesitter" then return end
    if data.kind ~= "install" and data.kind ~= "update" then return end

    -- ensure it’s on rtp before calling any TS commands
    pcall(vim.cmd.packadd, "nvim-treesitter")
    pcall(vim.cmd, "silent! TSUpdate")
  end,
})

-- Ensure parsers are installed (works once TS is loaded)
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy", -- replace with your own “init done” event if you don’t use one
  callback = function()
    pcall(vim.cmd.packadd, "nvim-treesitter")

    local ok, parsers = pcall(require, "nvim-treesitter.parsers")
    if not ok then return end

    local want = { "go", "javascript", "typescript" }
    for _, lang in ipairs(want) do
      if not parsers.has_parser(lang) then
        pcall(vim.treesitter.language.add, lang) -- no-op if not supported
      end
    end

    -- In practice you still want TSInstall/TSUpdate to fetch parsers:
    -- this will install missing ones and update existing.
    pcall(vim.cmd, "silent! TSInstallSync go javascript typescript")
  end,
})

