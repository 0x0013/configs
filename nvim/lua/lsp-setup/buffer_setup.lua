local utils = require('utils')

-- setup general keymaps
local function setup_general_keymaps(_, buffer_nr)
    -- NOTE(vir): now using fzf-lua
    -- utils.map('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<cr>', { silent = true }, buffer_nr)
    -- utils.map('n', '<leader>u', '<cmd>lua vim.lsp.buf.references()<cr>', { silent = true }, buffer_nr)
    -- utils.map('n', '<leader>U', '<cmd>lua vim.lsp.buf.document_symbols()<cr>', { silent = true }, buffer_nr)
    -- utils.map('n', '<a-cr>', '<cmd>lua vim.lsp.buf.code_action()<cr>', { silent = true }, buffer_nr)

    utils.map('n', '<leader>r','<cmd>lua vim.lsp.buf.rename()<cr>', { silent = true }, buffer_nr)
    utils.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { silent = true }, buffer_nr)

    utils.map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({ float = { border = "rounded", focusable = false } })<cr>', { silent = true }, buffer_nr)
    utils.map('n', ']e', '<cmd>lua vim.diagnostic.goto_next({ float = { border = "rounded", focusable = false } })<cr>', { silent = true }, buffer_nr)
    utils.map('n', '<leader>e', '<cmd>lua require("lsp-setup/utils").toggle_diagnostics_list()<cr>', { silent = true }, buffer_nr)
end

-- setup independent keymaps
local function setup_independent_keymaps(client, buffer_nr)
    if client.resolved_capabilities.document_formatting then
        utils.map('n','<c-f>', '<cmd>lua vim.lsp.buf.formatting()<cr>', { silent = true }, buffer_nr)
    end

    if client.resolved_capabilities.document_range_formatting then
        utils.map('v','<c-f>', '<cmd>lua vim.lsp.buf.range_formatting()<cr>', { silent = true }, buffer_nr)
    end
end

-- setup buffer options
local function setup_options(_, buffer_nr)
    vim.api.nvim_buf_set_option(buffer_nr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- setup buffer autocommands
local function setup_autocmds(client, _)
    if client.resolved_capabilities.document_highlight then
        vim.cmd [[
            augroup LspHighlights
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup end
        ]]
    end

    if client.resolved_capabilities.document_symbol then
        vim.cmd [[
            augroup LspStates
                autocmd! * <buffer>
                autocmd CursorMoved,InsertLeave,BufEnter <buffer> lua require('lsp-setup/utils').refresh_tag_state()
                autocmd BufLeave <buffer> lua require('lsp-setup/utils').reset_tag_state()
                " autocmd CursorHoldI <buffer> lua require('lsp-setup/utils').cmd_line_diagnostics()
                " autocmd CursorMovedI <buffer> echo ''
            augroup end
        ]]
    end

    vim.cmd [[
        augroup LspPopups
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.diagnostic.open_float(0, { border = 'rounded', focusable = false, scope = 'line' })
            " autocmd CursorHold <buffer> lua vim.lsp.buf.hover()
            " autocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()
        augroup end
    ]]
end

-- setup highlights
local function setup_highlights()
    vim.cmd [[
        highlight! link LspReferenceRead IncSearch
        highlight! link LspReferenceWrite IncSearch
        highlight! clear LspReferenceText
    ]]

    require('lsp-setup/utils').setup_lsp_icon_highlights()
end

return {
    setup_general_keymaps = setup_general_keymaps,
    setup_independent_keymaps = setup_independent_keymaps,
    setup_options = setup_options,
    setup_autocmds = setup_autocmds,
    setup_highlights = setup_highlights
}

