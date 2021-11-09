-- auto install packer.nvim if not exists
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[ packadd packer.nvim ]]
end

vim.cmd [[ command! Ps PackerSync ]]
return require('packer').startup({function()
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nathom/filetype.nvim'
    use 'lewis6991/impatient.nvim'

    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        event = 'BufRead',
        config = "require('plug-config/treesitter')"}

    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use 'akinsho/nvim-bufferline.lua'

    use 'steelsojka/pears.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'aserowy/tmux.nvim'
    use 'b3nj5m1n/kommentary'

    use 'ibhagwan/fzf-lua'
    use 'vijaymarupudi/nvim-fzf'

    use 'neovim/nvim-lspconfig'
    use 'ray-x/lsp_signature.nvim'
    use { 'hrsh7th/nvim-cmp',
        requires = {
            { 'onsails/lspkind-nvim', event = 'InsertEnter' },
            { 'L3MON4D3/LuaSnip', event = 'InsertEnter' },
            { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }
        },
        config = "require('plug-config/completion')",
        after = { 'LuaSnip', 'lspkind-nvim' } }

    use { 'godlygeek/tabular', cmd = 'Tab' }
    use { 'liuchengxu/vista.vim', cmd = 'Vista' }
    use { 'tpope/vim-eunuch', cmd = {'Delete', 'Rename'} }
    use { 'tpope/vim-fugitive', cmd = {'G', 'Gread'} }

    use 'bluz71/vim-nightfly-guicolors'
    use 'bluz71/vim-moonfly-colors'
    use 'shaunsingh/moonlight.nvim'
    use 'sainnhe/gruvbox-material'
    use 'RRethy/nvim-base16'
    use 'sainnhe/everforest'
    use 'Mofiqul/vscode.nvim'
    use 'EdenEast/nightfox.nvim'
    use 'mrjones2014/lighthaus.nvim'
    use 'https://gitlab.com/protesilaos/tempus-themes-vim.git'

    use { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' }
end, config = { compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua' }})

