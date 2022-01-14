local lsp = require("lspconfig")
local setup_buffer = require("lsp-setup/buffer_setup")
local oslib = require("lib/oslib")

-- setup keymaps and autocommands
local on_attach = function(client, buffer_nr)
    print("[LSP] Active")
    -- print('[LSP] Active : ' .. oslib.get_cwd())

    setup_buffer.setup_general_keymaps(client, buffer_nr)
    setup_buffer.setup_independent_keymaps(client, buffer_nr)
    setup_buffer.setup_options(client, buffer_nr)
    setup_buffer.setup_autocmds(client, buffer_nr)
    setup_buffer.setup_highlights()
end

-- pyright setup
lsp["pyright"].setup {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = on_attach,
    flags = {debounce_text_changes = 150}
}

-- clangd setup
lsp["clangd"].setup {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=bundled", "--header-insertion=iwyu" },
    on_attach = on_attach,
    flags = {debounce_text_changes = 150}
}

-- sumneko_lua setup
local sumneko_lua_root = oslib.get_homedir() .. "/.local/lsp/lua-language-server/"
local sumneko_lua_bin = sumneko_lua_root .. "bin/" .. oslib.get_os() .. "/lua-language-server"
lsp["sumneko_lua"].setup {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    cmd = {sumneko_lua_bin, "-E", sumneko_lua_root .. "main.lua"},
    settings = {
        Lua = {
            runtime = {version = "LuaJIT", path = vim.split(package.path, ";")},
            diagnostics = {globals = {"vim", "use"}},
            workspace = { library = {[vim.fn.expand("$VIMRUNTIME/lua")] = true, [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true} }
        }
    },
    on_attach = on_attach,
    flags = {debounce_text_changes = 150}
}

-- cmake setup
lsp['cmake'].setup {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = on_attach,
    flags = {debounce_text_changes = 150}
}

-- null-ls setup
local formatting = require('null-ls').builtins.formatting
require('null-ls').setup({
    sources = { formatting.lua_format, formatting.autopep8, formatting.prettier },
    on_attach = function(client, buffer_nr) setup_buffer.setup_independent_keymaps(client, buffer_nr) end
})

