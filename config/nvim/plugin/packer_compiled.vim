" Automatically generated packer.nvim plugin loader code

lua << END
local plugins = {
  ["completion-buffers"] = {
    config = { "require'plugin.rc.completion-buffers'.config()" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/completion-buffers"
  },
  ["completion-nvim"] = {
    after = { "nvim-lspconfig" },
    config = { "require'plugin.rc.completion-nvim'.config()" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/completion-nvim"
  },
  ["completion-treesitter"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/completion-treesitter"
  },
  ["diagnostic-nvim"] = {
    after = { "nvim-lspconfig" },
    config = { "require'plugin.rc.diagnostic-nvim'.config()" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/diagnostic-nvim"
  },
  ["nvim-lspconfig"] = {
    config = { "require'plugin.rc.nvim-lspconfig'.config()" },
    load_after = {
      ["completion-nvim"] = true,
      ["diagnostic-nvim"] = true
    },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "require'plugin.rc.nvim-treesitter'.config()" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  rainbow_csv = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/rainbow_csv"
  },
  ["vim-python-pep8-indent"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/vim-python-pep8-indent"
  },
  ["vim-table-mode"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/vim-table-mode"
  },
  ["vim-vsnip"] = {
    config = { "require'plugin.rc.vim-vsnip'.config()" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ"
  },
  ["vscode-python"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/sugi/.local/share/nvim/site/pack/packer/opt/vscode-python"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

_packer_load = nil

local function handle_after(name, before)
  local plugin = plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    _packer_load({name}, {})
  end
end

_packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if plugins[name].commands then
      for _, cmd in ipairs(plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if plugins[name].keys then
      for _, key in ipairs(plugins[name].keys) do
        del_maps[key] = true
      end
    end
  end

  for cmd, _ in pairs(del_cmds) do
    vim.cmd('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.cmd(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      vim._update_package_paths()
      if plugins[name].config then
        for _i, config_line in ipairs(plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if plugins[name].after then
        for _, after_name in ipairs(plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.cmd(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
  elseif cause.keys then
    local keys = cause.keys
    local extra = ''
    while true do
      local c = vim.fn.getchar(0)
      if c == 0 then break end
      extra = extra .. vim.fn.nr2char(c)
    end

    if cause.prefix then
      local prefix = vim.v.count and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    -- NOTE: I'm not sure if the below substitution is correct; it might correspond to the literal
    -- characters \<Plug> rather than the special <Plug> key.
    vim.fn.feedkeys(string.gsub(string.gsub(cause.keys, '^<Plug>', '\\<Plug>') .. extra, '<[cC][rR]>', '\r'))
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

-- Pre-load configuration
-- Setup for: nvim-lspconfig
require'plugin.rc.nvim-lspconfig'.setup()
-- Setup for: vim-table-mode
require'plugin.rc.vim-table-mode'.setup()
-- Setup for: vim-vsnip
require'plugin.rc.vim-vsnip'.setup()
-- Setup for: completion-buffers
require'plugin.rc.completion-buffers'.setup()
-- Setup for: diagnostic-nvim
require'plugin.rc.diagnostic-nvim'.setup()
-- Setup for: completion-nvim
require'plugin.rc.completion-nvim'.setup()
-- Post-load configuration
-- Config for: express_line.nvim
require'plugin.rc.express_line-nvim'.config()
-- Config for: telescope.nvim
require'plugin.rc.telescope-nvim'.config()
-- Conditional loads
vim._update_package_paths()
END

function! s:load(names, cause) abort
call luaeval('_packer_load(_A[1], _A[2])', [a:names, a:cause])
endfunction

" Runtimepath customization

" Load plugins in order defined by `after`

" Command lazy-loads

" Keymap lazy-loads

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  au FileType csv ++once call s:load(['rainbow_csv'], { "ft": "csv" })
  au FileType python ++once call s:load(['vscode-python', 'vim-python-pep8-indent'], { "ft": "python" })
  au FileType markdown ++once call s:load(['vim-table-mode'], { "ft": "markdown" })
  " Event lazy-loads
  au BufNewFile * ++once call s:load(['nvim-lspconfig', 'completion-nvim', 'diagnostic-nvim', 'nvim-treesitter'], { "event": "BufNewFile *" })
  au InsertEnter * ++once call s:load(['vim-vsnip', 'vim-vsnip-integ', 'completion-buffers', 'completion-treesitter'], { "event": "InsertEnter *" })
  au BufRead * ++once call s:load(['nvim-lspconfig', 'completion-nvim', 'diagnostic-nvim', 'nvim-treesitter'], { "event": "BufRead *" })
augroup END
