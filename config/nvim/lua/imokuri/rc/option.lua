local g = vim.g
local o = vim.opt

-- -----------------------------------------------------------------------------
-- Disable builtin {{{

g.did_install_default_menus = 1
g.did_install_syntax_menu = 1
g.loaded_2html_plugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logiPat = 1
g.loaded_man = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_rrhelper = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.skip_loading_mswin = 1

-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1
-- g.loaded_netrwSettings = 1

-- }}}

-- -----------------------------------------------------------------------------
-- NetRW {{{

g.netrw_liststyle = 1
g.netrw_banner = 0
g.netrw_sizestyle = "H"
g.netrw_timefmt = "%Y/%m/%d(%a) %H:%M:%S"
g.netrw_home = os.getenv("HOME")
g.netrw_bufsettings = "noma nomod nu rnu nowrap ro nobl"

-- }}}

-- -----------------------------------------------------------------------------
-- Neovim provider {{{

g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- }}}

-- -----------------------------------------------------------------------------
-- View {{{

o.number = true
o.relativenumber = true
o.list = true
o.listchars = {
    tab = "< >",
    trail = "-",
    extends = "»",
    precedes = "«",
}
o.showmatch = true
o.breakindent = true
o.showbreak = "↳"
o.breakindentopt = "sbr"
o.foldenable = false
o.foldmethod = "indent" -- "expr"
-- o.foldexpr = "nvim_treesitter#foldexpr()"
o.scrolloff = 5
o.showmode = false
o.updatetime = 250
o.pumblend = 20
o.pumheight = 10
o.diffopt:append({ "algorithm:patience", "indent-heuristic" })
o.termguicolors = true
o.shortmess:append("c")
o.equalalways = false
o.winbar = "%{%v:lua.require'imokuri.util'.winbar()%}"
o.cmdheight = 0
o.cursorline = true
o.cursorlineopt = "number"

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
o.virtualedit:append({ "block" })
-- o.clipboard:append({ "unnamedplus" })
o.completeopt = { "menu", "menuone", "noselect" }
o.mouse = ""

-- local uname = vim.fn.substitute(vim.fn.system("uname -r"), "\n", "", "")
-- if string.match(uname, "microsoft") then
--     g.clipboard = {
--         name = "win32yank",
--         copy = {
--             ["+"] = "win32yank.exe -i --crlf",
--             ["*"] = "win32yank.exe -i --crlf",
--         },
--         paste = {
--             ["+"] = "win32yank.exe -o --lf",
--             ["*"] = "win32yank.exe -o --lf",
--         },
--         cache_enabled = 0,
--     }
-- end

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

o.wildmode = { "longest", "full" }
-- o.dictionary = "/usr/share/dict/words"

-- }}}

-- vim:foldmethod=marker
