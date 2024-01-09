vim.filetype.add({
  extension = {
    ejs = 'html',
    -- svelte = 'html',
  },
  filename = {
--    ['.foorc'] = 'toml',
 --   ['/etc/foo/config'] = 'toml',
  },
  --[[ pattern = {
    ['.*/etc/foo/.*'] = 'fooscript',
    ['${XDG_CONFIG_HOME}/foo/git'] = 'git',
    ['README.(a+)$'] = function(path, bufnr, ext)
      if ext == 'md' then
        return 'markdown'
      elseif ext == 'rst' then
        return 'rst'
      end
    end,
  },
  ]]--
})

