-- one file per line with timestamp information and file size
vim.g.netrw_liststyle = 1

-- suppress the banner
vim.g.netrw_banner = 0

-- human-readable
vim.g.netrw_sizestyle = 'H'

-- specify format string to vim's strftime()
vim.g.netrw_timefmt = '%Y/%m/%d(%a) %H:%M:%S'

-- The home directory for where bookmarks and history are saved
vim.g.netrw_home = os.getenv("HOME")

-- the settings that netrw buffers have
vim.g.netrw_bufsettings = 'noma nomod nu rnu nowrap ro nobl'
