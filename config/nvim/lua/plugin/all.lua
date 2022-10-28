return {
    -- Packer can manage itself as an optional plugin
    { "wbthomason/packer.nvim", opt = true },

    -- Improve performance
    { "lewis6991/impatient.nvim" },

    -- Color scheme
    {
        "catppuccin/nvim",
        as = "catppuccin",
        run = ":CatppuccinCompile",
        config = "require'plugin.rc.catppuccin'.config()",
    },
    {
        "levouh/tint.nvim",
        config = function() require("tint").setup() end,
    },

    -- Filetype: python
    { "Vimjas/vim-python-pep8-indent", ft = { "python" } },

    -- Filetype: csv
    { "mechatroner/rainbow_csv", ft = { "csv" } },

    -- Filetype: markdown
    {
        "dhruvasagar/vim-table-mode",
        ft = { "markdown" },
        setup = "require'plugin.rc.vim-table-mode'.setup()",
    },

    -- Filetype: terraform
    {
        "hashivim/vim-terraform",
        ft = { "terraform" },
        setup = "require'plugin.rc.vim-terraform'.setup()",
    },

    -- Filetype: Jenkinsfile
    { "martinda/Jenkinsfile-vim-syntax", ft = { "Jenkinsfile" } },

    -- Filetype: ansible
    {
        "thiagoalmeidasa/vim-ansible-vault",
        ft = { "yaml", "yaml.ansible", "ansible_host", "jinja2" },
        cmd = { "AnsibleVaultEncrypt", "AnsibleVaultDecrypt" },
    },

    -- Sonic template
    {
        "mattn/vim-sonictemplate",
        setup = "vim.g.sonictemplate_vim_template_dir = {string.format('%s/template', vim.fn.stdpath('config'))}",
    },

    -- Quick highlight
    {
        "t9md/vim-quickhl",
        keys = "<Leader>m",
        config = "require'plugin.rc.vim-quickhl'.config()",
    },

    -- Git sign
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = "require'plugin.rc.gitsigns'.config()",
    },

    -- Indent Guide
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        after = {
            "nvim-treesitter",
        },
        config = "require'plugin.rc.indent-blankline'.config()",
    },

    -- Suda
    {
        "lambdalisue/suda.vim",
        setup = "vim.g.suda_smart_edit = 1",
    },

    -- Easy align
    {
        "junegunn/vim-easy-align",
        cmd = { "EasyAlign" },
        setup = "require'plugin.rc.easy-align'.setup()",
    },

    -- Comment
    {
        "numToStr/Comment.nvim",
        keys = "<Leader>c",
        config = "require'plugin.rc.comment-nvim'.config()",
    },

    -- Line diff
    {
        "AndrewRadev/linediff.vim",
        cmd = { "Linediff" },
    },

    -- Colorizer
    {
        "norcalli/nvim-colorizer.lua",
        cmd = { "ColorizerToggle" },
    },

    -- UI
    {
        "folke/noice.nvim",
        event = "VimEnter",
        config = "require'plugin.rc.noice-nvim'.config()",
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },

    -- Terminal
    {
        "kassio/neoterm",
        keys = {
            "<C-t>",
            "<C-g>",
        },
        config = "require'plugin.rc.neoterm'.config()",
    },

    -- REPL
    {
        "IMOKURI/repl.vim",
        cmd = {
            "Topen",
            "Ttoggle",
        },
    },

    -- Clever-f
    {
        "rhysd/clever-f.vim",
        event = { "BufRead", "BufNewFile" },
    },

    -- Sandwich
    {
        "machakann/vim-sandwich",
        event = { "BufRead", "BufNewFile" },
        setup = "vim.keymap.set({'n', 'x'}, 's', '<Nop>')",
    },

    -- Operator
    {
        "kana/vim-operator-replace",
        requires = {
            "kana/vim-operator-user",
        },
        config = "vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(operator-replace)')",
    },

    -- Text Objects
    {
        "kana/vim-textobj-line",
        requires = {
            "kana/vim-textobj-user",
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        run = ":TSUpdate",
        config = "require'plugin.rc.nvim-treesitter'.config()",
    },

    -- { "nvim-treesitter/nvim-treesitter-context", after = "nvim-treesitter" },
    { "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter" },
    { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },

    -- Auto completion
    {
        "hrsh7th/nvim-cmp",
        requires = {
            "lukas-reineke/cmp-under-comparator",
            "onsails/lspkind.nvim",
        },
        event = {
            "BufReadPre",
            "CmdlineEnter",
            "InsertEnter",
        },
        config = "require'plugin.rc.nvim-cmp'.config()",
    },
    { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp", config = "require'plugin.rc.nvim-cmp'.cmdline_config()" },
    { "hrsh7th/cmp-emoji", after = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
    { "hrsh7th/cmp-path", after = "nvim-cmp" },
    { "lukas-reineke/cmp-rg", after = "nvim-cmp" },
    { "ray-x/cmp-treesitter", after = "nvim-cmp" },
    { "octaltree/cmp-look", after = "nvim-cmp" },

    -- Snippet
    {
        "hrsh7th/vim-vsnip",
        -- event = "InsertEnter",
        after = {
            "nvim-cmp",
        },
        setup = "require'plugin.rc.vim-vsnip'.setup()",
        config = "require'plugin.rc.vim-vsnip'.config()",
    },
    { "hrsh7th/cmp-vsnip", after = { "vim-vsnip" } },

    -- Auto Pairs
    {
        "windwp/nvim-autopairs",
        -- event = "InsertEnter",
        after = {
            "nvim-cmp",
        },
        config = "require'plugin.rc.nvim-autopairs'.config()",
    },

    -- LSP
    {
        "williamboman/mason-lspconfig.nvim",
        requires = {
            "Mofiqul/trld.nvim",
            "neovim/nvim-lspconfig",
            "smjonas/inc-rename.nvim",
            "williamboman/mason.nvim",
        },
        after = {
            "cmp-nvim-lsp",
            "inc-rename.nvim",
            "mason.nvim",
            "nvim-lspconfig",
            "trld.nvim",
        },
        config = "require'plugin.rc.mason-lspconfig'.config()",
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        config = "require'plugin.rc.lualine'.config()",
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            "<Leader>D",
            "<Leader>E",
            "<Leader>[",
            "<Leader>]",
            "<Leader>b",
            "<Leader>d",
            "<Leader>f",
            "<Leader>g",
        },
        requires = {
            "kyazdani42/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "nvim-telescope/telescope-smart-history.nvim",
            "nvim-telescope/telescope-symbols.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "rcarriga/nvim-notify",
            "tami5/sqlite.lua",
        },
        config = "require'plugin.rc.telescope-nvim'.config()",
    },
    {
        "natecraddock/telescope-zf-native.nvim",
        after = "telescope.nvim",
        config = "require'plugin.rc.telescope-nvim'.zf_native()",
    },
    {
        "smartpde/telescope-recent-files",
        keys = "<Leader>o",
        after = "telescope.nvim",
        config = "require'plugin.rc.telescope-nvim'.recent_files()",
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        keys = "<Leader>e",
        after = "telescope.nvim",
        config = "require'plugin.rc.telescope-nvim'.file_browser()",
    },
    {
        "tamago324/telescope-sonictemplate.nvim",
        keys = "<Leader>s",
        after = {
            "telescope.nvim",
            "vim-sonictemplate",
        },
        config = "require'plugin.rc.telescope-nvim'.sonictemplate()",
    },
    {
        "IMOKURI/apyrori.nvim",
        ft = { "python" },
        keys = "<Leader>i",
        requires = {
            "telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        after = "telescope.nvim",
        config = "require'plugin.rc.telescope-nvim'.apyrori()",
    },

    -- Local Development
    -- "~/github/xxx.nvim",
    -- "~/github/apyrori.nvim",
}
