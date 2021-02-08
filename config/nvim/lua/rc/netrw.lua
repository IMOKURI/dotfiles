local g = vim.g

-- one file per line with timestamp information and file size
g.netrw_liststyle = 1

-- suppress the banner
g.netrw_banner = 0

-- human-readable
g.netrw_sizestyle = 'H'

-- specify format string to vim's strftime()
g.netrw_timefmt = '%Y/%m/%d(%a) %H:%M:%S'

-- The home directory for where bookmarks and history are saved
g.netrw_home = os.getenv("HOME")

-- the settings that netrw buffers have
g.netrw_bufsettings = 'noma nomod nu rnu nowrap ro nobl'
