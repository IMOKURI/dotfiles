return {
    -- Packer can manage itself as an optional plugin
    {'wbthomason/packer.nvim', opt = true},

    -- Improve performance
    {
        'lewis6991/impatient.nvim',
        config = "require('impatient')",
    },

    -- Color scheme
    -- {
    --     'IMOKURI/challenger-deep-theme-vim',
    --     -- config = [[vim.cmd("colorscheme challenger_deep")]],
    -- },
    {
        'Yagua/nebulous.nvim',
        config = "require'plugin.rc.nebulous-nvim'.config()",
    },
    -- {
    --     'rmehri01/onenord.nvim',
    --     -- config = [[vim.cmd("colorscheme onenord")]],
    -- },

    -- Filetype
    -- {
    --     'nathom/filetype.nvim',
    --     config = "require'plugin.rc.filetype-nvim'.config()",
    -- },

    -- Filetype: python
    {'Vimjas/vim-python-pep8-indent', ft = {'python'}},

    -- Filetype: csv
    {'mechatroner/rainbow_csv', ft = {'csv'}},

    -- Filetype: markdown
    {
        'dhruvasagar/vim-table-mode',
        ft = {'markdown'},
        setup = "require'plugin.rc.vim-table-mode'.setup()",
    },

    -- Filetype: terraform
    {
        'hashivim/vim-terraform',
        ft = {'terraform'},
        setup = "require'plugin.rc.vim-terraform'.setup()",
    },

    -- Filetype: Jenkinsfile
    {'martinda/Jenkinsfile-vim-syntax', ft = {'Jenkinsfile'}},

    -- Filetype: ansible
    {
        'pearofducks/ansible-vim',
        ft = {'yaml', 'yaml.ansible', 'ansible_hosts', 'jinja2'},
        setup = "require'plugin.rc.ansible-vim'.setup()",
    },
    {
        'thiagoalmeidasa/vim-ansible-vault',
        ft = {'yaml', 'yaml.ansible', 'ansible_host', 'jinja2'},
        cmd = {'AnsibleVaultEncrypt', 'AnsibleVaultDecrypt'}
    },

    -- Paste image
    -- Require xclip
    -- {
    --     'ekickx/clipboard-image.nvim',
    --     ft = {'markdown'},
    --     config = "require'plugin.rc.clipboard-image'.config()",
    -- },

    -- Capture
    {'tyru/capture.vim', cmd = {'Capture'}},

    -- Sonic template
    {
        'mattn/vim-sonictemplate',
        setup = "vim.g.sonictemplate_vim_template_dir = {string.format('%s/template', vim.fn.stdpath('config'))}",
    },

    -- Register
    {'tversteeg/registers.nvim'},

    -- Cursor line/word
    {'yamatsum/nvim-cursorline'},

    -- Quick highlight
    {
        't9md/vim-quickhl',
        keys = "<Leader>m",
        config = "require'plugin.rc.vim-quickhl'.config()",
    },

    -- Line number interval
    {
        'IMOKURI/line-number-interval.nvim',
        after = {
            "nebulous.nvim",
        },
        setup = "require'plugin.rc.line-number-interval'.setup()",
    },

    -- Git sign
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = "require'plugin.rc.gitsigns'.config()",
    },

    -- Indent Guide
    {
        'lukas-reineke/indent-blankline.nvim',
        event = "BufReadPre",
        after = {
            "nvim-treesitter",
        },
        config = "require'plugin.rc.indent-blankline'.config()",
    },

    -- Suda
    {
        'lambdalisue/suda.vim',
        setup = "vim.g.suda_smart_edit = 1",
    },

    -- Easy align
    {
        'junegunn/vim-easy-align',
        cmd = {'EasyAlign'},
        setup = "require'plugin.rc.easy-align'.setup()",
    },

    -- Comment
    {
        'numToStr/Comment.nvim',
        config = "require'plugin.rc.comment-nvim'.config()",
    },

    -- Line diff
    {
        'AndrewRadev/linediff.vim',
        cmd = {'Linediff'},
    },

    -- Colorizer
    {
        'norcalli/nvim-colorizer.lua',
        cmd = {'ColorizerToggle'},
    },

    -- Terminal
    {
        'kassio/neoterm',
        cmd = {
            'Topen',
            'Ttoggle'
        },
        setup = "require'plugin.rc.neoterm'.setup()",
    },

    -- REPL
    {'IMOKURI/repl.vim'},

    -- Search
    {
        'kevinhwang91/nvim-hlslens',
        event = {'BufRead', 'BufNewFile'},
        config = "require'plugin.rc.nvim-hlslens'.config()",
    },

    -- Clever-f
    {
        'rhysd/clever-f.vim',
        event = {'BufRead', 'BufNewFile'},
    },

    -- Sandwich
    {
        'machakann/vim-sandwich',
        event = {'BufRead', 'BufNewFile'},
    },

    -- Operator
    {
        'kana/vim-operator-replace',
        requires = {
            "kana/vim-operator-user",
        },
        config = "require'plugin.rc.operator'.config()",
    },

    -- Text Objects
    {
        'kana/vim-textobj-line',
        requires = {
            "kana/vim-textobj-user",
        },
    },
    {
        'vimtaku/vim-textobj-keyvalue',
        requires = {
            "kana/vim-textobj-user",
        },
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        event = "BufRead",
        run = ":TSUpdate",
        config = "require'plugin.rc.nvim-treesitter'.config()",
    },

    {'nvim-treesitter/nvim-treesitter-refactor', after = "nvim-treesitter"},
    {'nvim-treesitter/nvim-treesitter-textobjects', after = "nvim-treesitter"},
    {'p00f/nvim-ts-rainbow', after = "nvim-treesitter"},
    {'romgrk/nvim-treesitter-context', after = "nvim-treesitter"},

    -- Auto completion
    {
        'hrsh7th/nvim-cmp',
        requires = {
            "lukas-reineke/cmp-under-comparator",
        },
        event = {
            "BufReadPre",
            "CmdlineEnter",
            "InsertEnter"
        },
        config = "require'plugin.rc.nvim-cmp'.config()",
    },
    {"hrsh7th/cmp-buffer", after = "nvim-cmp"},
    {"hrsh7th/cmp-cmdline", after = "nvim-cmp", config="require'plugin.rc.nvim-cmp'.cmdline_config()"},
    {"hrsh7th/cmp-emoji", after = "nvim-cmp"},
    {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"},
    {"hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp"},
    {"hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp"},
    {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"},
    {"hrsh7th/cmp-path", after = "nvim-cmp"},
    {"lukas-reineke/cmp-rg", after = "nvim-cmp"},
    {"onsails/lspkind-nvim", after = "nvim-cmp"},
    {"ray-x/cmp-treesitter", after = "nvim-cmp"},

    -- Snippet
    {
        'hrsh7th/vim-vsnip',
        -- event = "InsertEnter",
        after = {
            "nvim-cmp",
        },
        setup = "require'plugin.rc.vim-vsnip'.setup()",
        config = "require'plugin.rc.vim-vsnip'.config()",
    },
    {"hrsh7th/cmp-vsnip", after = {"vim-vsnip"}},

    -- Auto Pairs
    {
        'windwp/nvim-autopairs',
        -- event = "InsertEnter",
        after = {
            "nvim-cmp",
        },
        config = "require'plugin.rc.nvim-autopairs'.config()",
    },

    -- LSP
    {'nvim-lua/lsp-status.nvim'},
    {
        'neovim/nvim-lspconfig',
        -- event = "BufReadPre",
        -- requires = {
        --     "b0o/schemastore.nvim",
        -- },
        config = "require'plugin.rc.nvim-lspconfig'.config()",
    },
    {
        'williamboman/nvim-lsp-installer',
        after = {
            "cmp-nvim-lsp",
            "lsp-status.nvim",
            "nvim-lspconfig",
        },
        config = "require'plugin.rc.nvim-lsp-installer'.config()",
    },

    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        config = "require'plugin.rc.lualine'.config()",
    },

    -- Session
    {
        'rmagatti/auto-session',
        cmd = {'SaveSession', 'RestoreSession', 'DeleteSession'},
        config = "require'plugin.rc.auto-session'.config()",
    },

    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        event = 'BufWinEnter',
        requires = {
            "kyazdani42/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-symbols.nvim",
        },
        config = "require'plugin.rc.telescope-nvim'.config()",
    },
    {
        'nvim-telescope/telescope-frecency.nvim',
        requires = {
            "tami5/sql.nvim",
        },
        after = {
            "telescope.nvim",
            -- "sql.nvim",
        },
        config = "require'plugin.rc.telescope-nvim'.frecency()",
    },
    -- {
    --     'nvim-telescope/telescope-fzf-writer.nvim',
    --     after = "telescope.nvim",
    --     config = "require'plugin.rc.telescope-nvim'.fzf_writer()",
    -- },
    {
        'nvim-telescope/telescope-fzy-native.nvim',
        after = "telescope.nvim",
        config = "require'plugin.rc.telescope-nvim'.fzy_native()",
    },
    {
        'tamago324/telescope-sonictemplate.nvim',
        after = {
            "telescope.nvim",
            "vim-sonictemplate",
        },
        config = "require'plugin.rc.telescope-nvim'.sonictemplate()",
    },
}
