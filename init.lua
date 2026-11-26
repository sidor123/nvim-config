vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.mouse = 'a'
opt.clipboard:append 'unnamedplus'
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.inccommand = 'split'
opt.cursorline = true
opt.scrolloff = 10
opt.completeopt = { 'menuone', 'noselect', 'popup' }

local map = vim.keymap.set
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>e', '<cmd>Neotree toggle left<CR>', { desc = 'Toggle Neo-tree sidebar' })
map('n', '<leader>E', '<cmd>Neotree toggle current<CR>', { desc = 'Toggle Neo-tree in current window' })
map('n', '<leader>c', '<cmd>quit<CR>', { desc = 'Close window' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Buffer diagnostics' })
map('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
for _, key in ipairs { 'h', 'j', 'k', 'l' } do
  map('n', '<C-' .. key .. '>', '<C-w>' .. key, { desc = 'Focus adjacent window' })
end

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('syntax-highlight', { clear = true }),
  pattern = { 'c', 'cpp', 'sh', 'diff', 'html' },
  callback = function(event)
    local lang = vim.treesitter.language.get_lang(event.match)
    if lang and vim.treesitter.language.add(lang) and vim.treesitter.query.get(lang, 'highlights') then vim.treesitter.start(event.buf, lang) end
  end,
})

-- Reuse tools already installed by Mason, after executables on the system PATH.
local mason_bin = vim.fn.stdpath 'data' .. '/mason/bin'
if vim.fn.isdirectory(mason_bin) == 1 then vim.env.PATH = vim.env.PATH .. ':' .. mason_bin end

vim.pack.add {
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/tiagovla/tokyodark.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'v3.x' },
  'https://github.com/goolord/alpha-nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/folke/which-key.nvim',
}

vim.cmd.colorscheme 'tokyodark'
vim.cmd.highlight 'Comment gui=none'
require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()
local pairs_plugin = require 'mini.pairs'
pairs_plugin.setup()
map('i', '<Tab>', function() return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>' end, { expr = true })
map('i', '<S-Tab>', function() return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>' end, { expr = true })
map('i', '<CR>', function()
  if vim.fn.pumvisible() == 0 then return pairs_plugin.cr() end
  local selected = vim.fn.complete_info({ 'selected' }).selected
  return vim.keycode(selected == -1 and '<C-n><C-y>' or '<C-y>')
end, { expr = true, replace_keycodes = false })
require('mini.statusline').setup { use_icons = true }
opt.showmode = false

require 'config.search'
require('neo-tree').setup {}
require('fidget').setup {}
require('todo-comments').setup { signs = false }
require('ibl').setup {}
local which_key = require 'which-key'
which_key.setup {}
which_key.add {
  { '<leader>s', group = 'Search' },
  { '<leader>h', group = 'Git hunks', mode = { 'n', 'x' } },
}
require 'config.dashboard'
require 'config.git'
require 'config.lsp'

local conform = require 'conform'
conform.setup {
  formatters_by_ft = { lua = { 'stylua' } },
  format_on_save = function(buf)
    local ft = vim.bo[buf].filetype
    if ft ~= 'c' and ft ~= 'cpp' then return { timeout_ms = 500, lsp_format = 'fallback' } end
  end,
}
map({ 'n', 'x' }, '<leader>f', function() conform.format { async = true, lsp_format = 'fallback' } end, { desc = 'Format code' })
