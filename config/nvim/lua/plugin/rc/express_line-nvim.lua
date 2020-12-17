local builtin = require('el.builtin')
local extensions = require('el.extensions')
local sections = require('el.sections')
-- local subscribe = require('el.subscribe')

local has_lsp_status, lsp_status = pcall(require, 'lsp-status')

local M = {}

local lsp_diag_indicator = {
    errors = 'E:',
    warnings = 'W:',
    info = 'I:',
    hints = 'H:',
    ok = 'Good!',
}

function M.config()
    local lsp_diagnostics = function(_, buffer)
        if not buffer.lsp or not has_lsp_status then
            return ''
        end

        local ok, diag = pcall(lsp_status.diagnostics)
        if not ok then
            return ''
        end

        local diag_list = {}
        if diag.errors and diag.errors > 0 then
            table.insert(diag_list, lsp_diag_indicator.errors .. ' ' .. diag.errors)
        end
        if diag.warnings and diag.warnings > 0 then
            table.insert(diag_list, lsp_diag_indicator.warnings .. ' ' .. diag.warnings)
        end
        if diag.info and diag.info > 0 then
            table.insert(diag_list, lsp_diag_indicator.info .. ' ' .. diag.info)
        end
        if diag.hints and diag.hints > 0 then
            table.insert(diag_list, lsp_diag_indicator.hints .. ' ' .. diag.hints)
        end

        local diag_status = vim.trim(table.concat(diag_list, ', '))

        if diag_status ~= '' then
            return '[' .. diag_status .. ']'
        end

        return '[' .. lsp_diag_indicator.ok .. ']'
    end

    local generator = function()
        return {
            extensions.mode,
            ' ',
            builtin.file_relative,
            sections.collapse_builtin {
                ' ',
                builtin.filetype,
            },
            sections.collapse_builtin {
                ' ',
                builtin.modified_flag,
                builtin.readonly_flag,
            },
            ' ',
            '[', builtin.line, ', ',  builtin.column, ']',
            ' ',
            lsp_diagnostics,
            sections.split,
        }
    end

    require('el').setup{generator = generator}
end

return M
