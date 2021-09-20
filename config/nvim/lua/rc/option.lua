local g = vim.g
local o = vim.opt

-- -----------------------------------------------------------------------------
-- Neovim provider {{{

if vim.fn.glob("~/.local/pipx/venvs/neovim-remote/bin/python") ~= "" then
    g.python3_host_prog = vim.fn.expand("~/.local/pipx/venvs/neovim-remote/bin/python")
end
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python_provider = 0
g.loaded_ruby_provider = 0

-- }}}

-- -----------------------------------------------------------------------------
-- View {{{

o.number = true
o.relativenumber = true
o.list = true
o.listchars = {
    tab = '→→',
    trail = '-',
    extends = '»',
    precedes = '«',
}
o.showmatch = true
o.colorcolumn = "120"
o.breakindent = true
o.showbreak = "↳"
o.breakindentopt = "sbr"
o.foldmethod = "indent"
o.foldnestmax = 10
o.scrolloff = 5
o.showmode = false
o.updatetime = 250
o.lazyredraw = true
o.pumblend = 20
o.pumheight = 10
o.diffopt:append({"algorithm:patience", "indent-heuristic"})
o.termguicolors = true
o.shortmess:append("c")

-- }}}

-- -----------------------------------------------------------------------------
-- Edit {{{

o.undofile = true
o.swapfile = true
o.backup = false
o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.shiftround = true
o.smartindent = true
o.virtualedit:append({"block"})
o.clipboard:append({"unnamedplus"})
o.completeopt = {"menuone", "noselect"}

local uname = vim.fn.substitute(vim.fn.system("uname -r"), "\n", "", "")
if string.match(uname, "microsoft") then
    g.clipboard = {
        name = "win32yank",
        copy = {
            ['+'] = "win32yank.exe -i --crlf",
            ['*'] = "win32yank.exe -i --crlf",
        },
        paste = {
            ['+'] = "win32yank.exe -o --lf",
            ['*'] = "win32yank.exe -o --lf",
        },
        cache_enabled = 0,
    }
end

-- }}}

-- -----------------------------------------------------------------------------
-- Search {{{

o.ignorecase = true
o.smartcase = true
o.wrapscan = true
o.fileignorecase = true
o.inccommand = "split"
o.keywordprg = ":help"

-- }}}

-- -----------------------------------------------------------------------------
-- Completion {{{

o.wildmode = {"longest", "full"}
o.dictionary = "/usr/share/dict/words"

-- }}}

-- vim:foldmethod=marker
