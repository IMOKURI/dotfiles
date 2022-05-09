vim.api.nvim_create_user_command("PylspAddPlugins", "PylspInstall pyls-isort python-lsp-black pylsp-mypy pyls-memestra", { bang = true })
